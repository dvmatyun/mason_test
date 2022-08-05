import 'package:{{name.snakeCase()}}/core/debug/debug_data_notifier.dart';
import 'package:{{name.snakeCase()}}/core/debug/debug_overlay.dart';
import 'package:{{name.snakeCase()}}/core/debug/quick_access_widgets.dart';
import 'package:{{name.snakeCase()}}/core/localization/localization_asset_loader.g.dart';
import 'package:{{name.snakeCase()}}/core/navigation/global_navigator.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/change_notifier_builder.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wraps the entire application into high level provider-like widgets
class AppWrapper extends StatelessWidget {
  final bool isDevelopmentMode;

  static ChangeNotifier? _debugNotifier;

  const AppWrapper({Key? key, required this.isDevelopmentMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _debugNotifier ??= isDevelopmentMode ? DebugNotifier() : EmptyNotifier();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: EasyLocalization(
        useOnlyLangCode: true,
        path: 'lib/core/localization/translations',
        supportedLocales: const [Locale('en'), Locale('cs')],
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),

        /// gives the ability to change MaterialApp's attributes through the debug menu
        child: ChangeNotifierBuilder(
          changeNotifier: _debugNotifier!,
          builder: (context, notifier) {
            final showPerformanceOverlay =
                isDevelopmentMode ? (notifier as DebugNotifier).showPerformanceOverlay : false;

            return Stack(
              textDirection: TextDirection.ltr,
              children: [
                MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: GlobalNavigator().navigationKey,
                  showPerformanceOverlay: showPerformanceOverlay,
                  theme: ThemeData(
                    pageTransitionsTheme: const PageTransitionsTheme(
                      builders: {
                        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                      },
                    ),
                  ),
                  home: const SizedBox(), //TODO: splash screen
                ),
                if (isDevelopmentMode)
                  DebugViewOverlay(
                    childrenQuickAccess: DebugMenuQuickAccess(debugNotifier: notifier as DebugNotifier),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
