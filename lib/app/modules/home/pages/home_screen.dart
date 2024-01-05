import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_card_product_widget.dart';
import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';
import '../../../config/themes/app_logos.dart';
import '../extensions/home_extensions.dart';
import '../widgets/home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = HomeCategory.wall.name;

  List _products = [];
  List _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    productJson();
  }

  Future<void> productJson() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final data = await json.decode(response);

    setState(() {
      _products = data['products'];
      _filteredProducts = List.from(_products);
    });
  }

  void _byCatalog(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) => product['catalog_type']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(height: 28, child: AppLogos.macrameMini),
        actions: [
          InkWell(
            onTap: () => context.goNamed(AppRoutes.notification.name),
            child: SizedBox(
              height: 24,
              width: 24,
              child: AppIcons.activeNotif,
            ),
          ),
          14.width,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeBannerWidget(),
              20.height,
              _buildMenuCategory(),
              16.height,
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 157 / 253,
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 16,
                ),
                itemCount: _filteredProducts.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  num price =
                      _filteredProducts[index]['product_price']['amount'];
                  return AppCardProductWidget(
                    imageUrl: _filteredProducts[index]['product_image'],
                    name: _filteredProducts[index]['product_name'],
                    price: price.toCurrencyRP(),
                    onDetails: () {
                      context.pushNamed(
                        AppRoutes.details.name,
                        pathParameters: {
                          'id_item': _filteredProducts[index]['id_item']
                        },
                      );
                    },
                  );
                },
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildMenuCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: List.generate(HomeCategory.values.length, (index) {
            final category = HomeCategory.values[index];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => setState(() {
                    selectedCategory = category.name;
                    _byCatalog(category.catalogType);
                  }),
                  child: Container(
                    width: 64,
                    height: 64,
                    padding: EdgeInsets.all(index == 1 || index == 0 ? 16 : 18),
                    decoration: BoxDecoration(
                      color: AppColors.darkVanilla.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: selectedCategory == category.name
                          ? Border.all(width: 0.5, color: AppColors.spanishGray)
                          : null,
                    ),
                    margin: EdgeInsets.only(
                      right: index == HomeCategory.values.length - 1 ? 0 : 16,
                    ),
                    child: selectedCategory == category.name
                        ? category.iconActive
                        : category.iconUnactive,
                  ),
                ),
                8.height,
                Padding(
                  padding: EdgeInsets.only(
                    right: index == HomeCategory.values.length - 1 ? 0 : 16,
                  ),
                  child: category.name.asSubtitleNormal(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    color: selectedCategory == category.name
                        ? null
                        : AppColors.spanishGray,
                    fontWeight: selectedCategory == category.name
                        ? FontWeight.w600
                        : null,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
