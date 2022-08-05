import 'package:{{name.snakeCase()}}/core/localization/translate.dart';
import 'package:{{name.snakeCase()}}/core/navigation/global_navigator.dart';
import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:easy_localization/easy_localization.dart';

export 'package:{{name.snakeCase()}}/core/structs/usecase.dart' show NoParams;

class GetCurrentLocale implements UseCase<String, NoParams> {
  final GlobalNavigator _globalNavigator;

  GetCurrentLocale({GlobalNavigator? globalNavigator}) : _globalNavigator = globalNavigator ?? GlobalNavigator();

  @override
  Future<String> call(NoParams params) async {
    final context = _globalNavigator.navigationKey.currentContext;
    final locale = context?.locale.languageCode ?? defaultLocale;
    return locale;
  }
}
