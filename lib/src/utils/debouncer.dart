import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int seconds;
  Timer? _timer;

  Debouncer({
    required this.seconds,
  });

  void run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(seconds: seconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
