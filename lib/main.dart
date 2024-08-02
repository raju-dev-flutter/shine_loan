import 'dart:async';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app_bootstrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrapper.init(
    mainAppWidget: const ShineLoanApp(),
    runApp: runApp,
  );
}
