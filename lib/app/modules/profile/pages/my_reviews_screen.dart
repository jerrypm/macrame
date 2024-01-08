import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  List _reviews = [];

  @override
  void initState() {
    super.initState();
    reviewsJson();
  }

  Future<void> reviewsJson() async {
    final String response =
        await rootBundle.loadString('assets/json/reviews.json');
    final data = await json.decode(response);

    setState(() {
      _reviews = data['reviews'];
    });
    debugPrint(_reviews.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: 'My Reviews'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        actions: const [],
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _reviews.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (BuildContext context, int index) {
            var item = _reviews[index];
            num price = item['price'];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8A959E).withOpacity(0.1),
                    offset: const Offset(0, 7),
                    blurRadius: 40,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 73,
                        height: 73,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item['image_url']),
                          ),
                        ),
                      ),
                      16.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          '${item['product_name']}'.asSubtitleBig(
                            color: const Color(0xFF606060),
                            fontWeight: FontWeight.w600,
                          ),
                          8.height,
                          price.toCurrency$().asSubtitleBig(
                                fontWeight: FontWeight.w700,
                              ),
                        ],
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < item['stars']
                                ? Icons.star
                                : Icons.star_outline,
                            size: 20.0,
                            color: const Color(0xFFF2C94C),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${item['date']}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: AppColors.spanishGray,
                        ),
                      ),
                    ],
                  ),
                  16.height,
                  'This macramé Leaf Wall Hanging beautifully captures the essence of nature through intricate knotting and delicate design.'
                      .asSubtitleBig()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
