import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';

class BookmarkCardProductWidget extends StatelessWidget {
  const BookmarkCardProductWidget({
    super.key,
    this.name = 'Product title',
    this.price = '\$ 1000',
    this.imageUrl =
        'https://i.pinimg.com/474x/a0/08/f6/a008f65c4fe17d5deff055e70c4b54ed.jpg',
    this.onDetails,
    this.onRemove,
  });
  final String name;
  final String price;
  final String imageUrl;
  final void Function()? onDetails;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetails,
      child: Container(
        height: 130,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 116,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.spanishGray, width: 0.5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            12.width,
            Flexible(
              child: Container(
                decoration: const BoxDecoration(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name.asSubtitleBig(
                          color: const Color(0xFF606060),
                          fontWeight: FontWeight.w600,
                        ),
                        8.height,
                        price.asSubtitleBig(
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onRemove,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: AppIcons.activeClear,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
