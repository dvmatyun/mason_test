import 'package:flutter/cupertino.dart';

abstract class PopupManager {
  /// Returns true if modal action completed with user approval
  Future<bool> showPopup({
    required BuildContext context,
    required RoutePageBuilder pageBuilder,
  });
}
