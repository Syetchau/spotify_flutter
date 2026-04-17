import 'package:flutter/cupertino.dart';

extension KeyboardExtension on BuildContext {
  /// Hides the soft keyboard by removing focus from the current node
  void hideKeyboard() {
    final FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}