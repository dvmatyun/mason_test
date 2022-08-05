import 'package:easy_localization/easy_localization.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public.dart' as ez;

/// String translation methods mapped to easy_localization
extension StringTranslateExtension on String {
  /// {@macro tr}
  String tr({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) =>
      ez.tr(this, args: args, namedArgs: namedArgs, gender: gender);

  /// {@macro plural}
  String plural(
    num value, {
    List<String>? args,
    NumberFormat? format,
  }) =>
      ez.plural(this, value, args: args, format: format);
}
