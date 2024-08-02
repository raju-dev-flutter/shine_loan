import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app_bloc_observer.dart';
import 'core/core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  Log.d("Title: ${message.notification!.title}");
  Log.d("Body: ${message.notification!.body}");
}

class AppBootstrapper {
  const AppBootstrapper._();

  static Future<void> init({
    required Widget mainAppWidget,
    required void Function(Widget) runApp,
  }) async {
    // Initialize firebase SDK
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Bloc.observer = AppBlocObserver();

    await PathProviderService.init();

    Future.wait([SharedPrefs.init()]);

    await setup();

    runApp(
      MultiRepositoryProvider(
        providers: repositoryProvider(),
        child: MultiBlocProvider(
          providers: blocProvider(),
          child: mainAppWidget,
        ),
      ),
    );
  }

  static repositoryProvider() {
    return [
      /// Authentication and Auth Repositories
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => sl<AuthenticationRepository>()),
    ];
  }

  static blocProvider() {
    return [
      /// Authentication and Auth
      BlocProvider<AuthenticationBloc>(
          create: (context) =>
              sl<AuthenticationBloc>()..add(const AppStarted())),
    ];
  }
}
