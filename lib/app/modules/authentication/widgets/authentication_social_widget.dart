import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';

class AuthenticationSocialWidget extends StatelessWidget {
  const AuthenticationSocialWidget({
    super.key,
    this.onGoogle,
    this.onFacebook,
  });

  final void Function()? onGoogle;
  final void Function()? onFacebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Flexible(
              child: Divider(color: AppColors.lightGrey),
            ),
            12.width,
            'Or'.asSubtitleNormal(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.w500,
            ),
            12.width,
            const Flexible(
              child: Divider(color: AppColors.lightGrey),
            ),
          ],
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onGoogle,
              child: Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightGrey,
                  ),
                ),
                child: Image.network(
                  "https://i.ibb.co/7WBNQ3M/281764.png",
                ),
              ),
            ),
            40.width,
            InkWell(
              onTap: onFacebook,
              child: Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightGrey,
                  ),
                ),
                child: Image.network(
                  "https://static.vecteezy.com/system/resources/previews/018/930/702/original/facebook-logo-facebook-icon-transparent-free-png.png",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
