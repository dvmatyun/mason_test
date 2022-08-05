import 'package:flutter_mason/core/locator/locator.dart';
import 'package:logger/logger.dart';

/// Used to run tests, where locator does not initialize
final _defaultLogger = Logger();

Logger get log => locator.isRegistered<Logger>() ? locator.get() : _defaultLogger;
