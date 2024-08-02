import 'package:flutter/foundation.dart';

@immutable
class Config {
  const Config._();

  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://i5apps.tech/gokulsantol',
  );
}
