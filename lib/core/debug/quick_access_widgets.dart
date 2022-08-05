import 'package:flutter_mason/core/debug/debug_data_notifier.dart';
import 'package:flutter_mason/core/navigation/global_navigator.dart';
import 'package:flutter_mason/core/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Set of widgets that are visible as soon as debug menu opened up
class DebugMenuQuickAccess extends StatelessWidget {
  final DebugNotifier debugNotifier;

  const DebugMenuQuickAccess({
    Key? key,
    required this.debugNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getPerformanceToggle(),
        _getCacheKillerButton(),
        _getNavigateToButton(),
      ],
    );
  }

  Widget _getPerformanceToggle() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Show performance overlay',
              style: AppTheme.typography.normalBoldBackgrounded,
            ),
          ),
          CupertinoSwitch(
              value: debugNotifier.showPerformanceOverlay,
              onChanged: (val) {
                debugNotifier.showPerformanceOverlay = val;
              }),
        ],
      );

  Widget _getCacheKillerButton() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: CupertinoButton(
          color: Colors.red.shade400,
          onPressed: debugNotifier.killCache,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Kill cache',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  Widget _getNavigateToButton() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: CupertinoButton(
          color: Colors.red.shade400,
          onPressed: () {
            //Some action: GlobalNavigator().pushAndRemoveUntil(FillPassengerProfileScreen.getRoute());
          },
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Navigate to ...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}
