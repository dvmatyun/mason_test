import 'package:{{name.snakeCase()}}/app/app.dart';
import 'package:{{name.snakeCase()}}/app/environment/app_environment.dart';
import 'package:{{name.snakeCase()}}/app/environment/configuration.dart';
import 'package:flutter/material.dart';

class PassengerApp extends StatelessWidget {
  final AppConfiguration configuration;

  const PassengerApp({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isDevelopmentMode: configuration.environment == AppEnvironment.development,
    );
  }
}
