import 'package:{{name.snakeCase()}}/app/app.dart';
import 'package:flutter/material.dart';

import 'environment/app_environment.dart';
import 'environment/configuration.dart';

class DriverApp extends StatelessWidget {
  final AppConfiguration configuration;

  const DriverApp({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isDevelopmentMode: configuration.environment == AppEnvironment.development,
    );
  }
}
