import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

extension ShowSnackbarExtension on BuildContext {
  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.error,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 18.0,
              color: Colors.white,
            ),
            12.width,
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
