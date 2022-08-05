import 'package:flutter_mason/app/environment/app_type.dart';
import 'package:flutter_mason/app/environment/configuration.dart';
import 'package:flutter_mason/core/locator/locator.dart';
import 'package:flutter/material.dart';

/// Builds content dependent on current app's environment [AppType]
class AppTypeBuilder extends StatelessWidget {
  final WidgetBuilder passengerBuilder;
  final WidgetBuilder driverBuilder;

  const AppTypeBuilder({
    Key? key,
    required this.passengerBuilder,
    required this.driverBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appType = locator.get<AppConfiguration>().appType;
    return appType == AppType.passenger ? passengerBuilder(context) : driverBuilder(context);
  }
}
