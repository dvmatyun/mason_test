import 'package:flutter_mason/core/logic/popup_logic/popup_manager.dart';
import 'package:flutter_mason/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PopupManagerImpl implements PopupManager {
  /// Returns true if modal action completed with user approval
  @override
  Future<bool> showPopup({
    required BuildContext context,
    required RoutePageBuilder pageBuilder,
  }) async {
    final dialogResult = await showGeneralDialog<bool>(
      context: context,
      pageBuilder: pageBuilder,
      barrierColor: AppTheme.colors.backgroundModal,
    );
    return dialogResult ?? false;
  }
}
