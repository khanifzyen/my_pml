import 'package:flutter/material.dart';

enum Status { info, error }

extension BuildContextExtension on BuildContext {
  void showSnackBar(String message, Status status) {
    final backgroundColor = status == Status.info ? Colors.black : Colors.red;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
