import 'package:macrame_app/app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

extension ShowDialogExtension on BuildContext {
  void showDialogWidget(
      {required Widget dialogContent, List<Widget>? actions}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          surfaceTintColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actionsAlignment: MainAxisAlignment.center,
          content: dialogContent,
          actions: actions,
        );
      },
    );
  }

  void showDialogText({required String message}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
