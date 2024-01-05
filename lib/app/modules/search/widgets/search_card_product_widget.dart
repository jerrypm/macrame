import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';

class SearchCardProductWidget extends StatelessWidget {
  const SearchCardProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A959E).withOpacity(0.1),
            offset: const Offset(0, 7),
            blurRadius: 40,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.spanishGray,
                width: 0.5,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://i.pinimg.com/474x/a0/08/f6/a008f65c4fe17d5deff055e70c4b54ed.jpg',
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          16.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'Procut Title'.asSubtitleBig(
                color: const Color(0xFF606060),
                fontWeight: FontWeight.w600,
              ),
              8.height,
              'Rp. 120.000'.asSubtitleBig(
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
