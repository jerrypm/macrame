import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../config/themes/app_colors.dart';

class AppCardProductWidget extends StatelessWidget {
  const AppCardProductWidget({
    super.key,
    this.name = 'Product title',
    this.price = 'Rp 100.000',
    this.imageUrl =
        'https://i.pinimg.com/474x/a0/08/f6/a008f65c4fe17d5deff055e70c4b54ed.jpg',
    this.onDetails,
  });
  final String name;
  final String price;
  final String imageUrl;
  final void Function()? onDetails;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetails,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.darkGrey,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  name.asSubtitleBig(
                    color: const Color(0xFF606060),
                    fontWeight: FontWeight.w400,
                  ),
                  price.asSubtitleNormal(
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
