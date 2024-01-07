import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:macrame_app/app/components/app_elevated_button_widget.dart';
import 'package:macrame_app/app/config/themes/app_logos.dart';

import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';
import '../../../core/helpers/app_prefs.dart';
import '../widgets/book_mark_card_product_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var data = await AppPrefs.getJsonFromSharedPreferences();
    setState(() {
      productList = data;
    });
    debugPrint(productList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Favorites'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoutes.cart.name),
            icon: SizedBox(
              height: 24,
              width: 24,
              child: AppIcons.activeCart,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.arsenic,
          onRefresh: () async {
            getData();
          },
          child: productList.isEmpty
              ? SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          44.height,
                          SizedBox(
                            height: 250,
                            width: 259,
                            child: AppLogos.emptyState,
                          ),
                          44.height,
                          "Empty Data".asTitleSemiBig(
                            color: AppColors.spanishGray,
                          ),
                          12.height,
                          "You haven't added your favorite macrame products yet"
                              .asTitleSmall(
                                  color: AppColors.spanishGray,
                                  textAlign: TextAlign.center),
                          44.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: AppElevatedButtonWidget(
                                onPressed: () {
                                  getData();
                                },
                                radius: 8,
                                elevation: 4,
                                backgroundColor: AppColors.arsenic,
                                child: 'Refresh'.asSubtitleBig(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: productList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (BuildContext context, int index) {
                    var item = productList[index];
                    num price = productList[index]['product_price']['amount'];
                    return BookmarkCardProductWidget(
                      name: item['product_name'],
                      price: price.toCurrencyRP(),
                      imageUrl: item['product_image'],
                      onRemove: () async {
                        await AppPrefs.removeJsonByIdFromSharedPreferences(
                          item['id_item'],
                        );
                        getData();
                      },
                      onDetails: () {
                        context.pushNamed(
                          AppRoutes.details.name,
                          pathParameters: {
                            'id_item': productList[index]['id_item']
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
