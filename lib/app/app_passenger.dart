import 'package:flutter_mason/app/app.dart';
import 'package:flutter_mason/app/environment/app_environment.dart';
import 'package:flutter_mason/app/environment/configuration.dart';
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
