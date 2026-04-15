import 'dart:async';
import 'dart:ui';

extension DoubleTapBlocker on VoidCallback {
  VoidCallback throttle([int milliseconds = 800]) {
    Timer? timer;

    return () {
      if (timer?.isActive ?? false) return;
      this();
      timer = Timer(Duration(milliseconds: milliseconds), () => timer = null);
    };
  }
}