import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shine_loan/feature/auth/auth.dart';

import '../config/config.dart';
import '../core/core.dart';
import 'app.dart';

class ShineLoanApp extends StatefulWidget {
  const ShineLoanApp({super.key});

  @override
  State<ShineLoanApp> createState() => _ShineLoanAppState();
}

class _ShineLoanAppState extends State<ShineLoanApp> {
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  @override
  void initState() {
    super.initState();

    localNotificationServices.requestNotificationPermission();
    localNotificationServices.firebaseInit(context);
    localNotificationServices.setupInteractMessage(context);

    localNotificationServices.getDeviceToken().then((token) {
      setState(() => Log.i("Device Token: $token"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (ctx, child) {
        return MaterialApp(
          title: 'Shine Loan',
          navigatorKey: NavigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: GeneratorTheme.lightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return Container();
                // return const SplashScreen();
              }
              if (state is AppPermissionNotGranted) {
                return const GetStartScreen();
                // return const PermissionScreen();
              }
              if (state is AuthenticationUnauthenticated) {
                return Container();
                // return const LoginScreen();
              }
              if (state is AuthenticationAuthenticated) {
                return Container();
                // return const RootScreen();
              }
              return Container();
              // return const UnknownScreen();
            },
          ),
        );
      },
    );
  }
}
