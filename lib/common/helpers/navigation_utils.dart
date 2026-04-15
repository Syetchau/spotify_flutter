import 'package:flutter/material.dart';

extension NavigationContext on BuildContext {

  void pushReplacement(Widget page) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => page));
  }

  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => page), (route) => false
    );
  }

  void back() {
    Navigator.pop(this);
  }
}