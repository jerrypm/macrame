import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeBannerWidget extends StatefulWidget {
  const HomeBannerWidget({super.key});

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  int _currentPage = 3;

  List _banners = [];

  @override
  void initState() {
    super.initState();
    bannerJson();
  }

  Future<void> bannerJson() async {
    final String response =
        await rootBundle.loadString('assets/json/banner.json');
    final data = await json.decode(response);

    setState(() {
      _banners = data['banners'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 228.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: _banners.length,
            options: CarouselOptions(
              height: 200,
              viewportFraction: 0.92,
              enableInfiniteScroll: false,
              initialPage: 2,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                height: 160,
                width: context.screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    "${_banners[index]['image_url']}",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          10.height,
          Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  width: _currentPage == index ? 18 : 4,
                  height: 4.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        _currentPage == index ? Colors.grey : Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
