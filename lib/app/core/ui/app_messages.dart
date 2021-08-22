import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class AppMessages {
  final BuildContext context;
  AppMessages._(this.context);

  factory AppMessages.of(BuildContext context) {
    return AppMessages._(context);
  }

  void showError(String message) => _showMessage(message, Colors.red);
  void showInfo(String message) => _showMessage(message, context.primaryColor);

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
