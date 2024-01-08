import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/core/helpers/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_elevated_button_widget.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';

enum DetailsColor {
  red,
  blue,
  yellow,
  purple,
}

extension DetailsColorExtensions on DetailsColor {
  Color get color {
    switch (this) {
      case DetailsColor.red:
        return const Color(0xFFE4DAD3);
      case DetailsColor.blue:
        return const Color(0xFFB4916C);
      case DetailsColor.yellow:
        return const Color(0xFFE4CBAD);
      case DetailsColor.purple:
        return const Color(0xFFE4CBAD);
      default:
        return const Color(0xFFE4DAD3);
    }
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, this.idItem});

  final int? idItem;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedIndex = 0;

  bool selectedBookmark = false;

  Map<String, dynamic> _products = {};

  @override
  void initState() {
    super.initState();
    productJson();
  }

  Future<void> productJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/product.json');
      final data = await json.decode(response);

      setState(() {
        List<dynamic> items = data['products'];

        for (var item in items) {
          if (item['id_item'] == widget.idItem.toString()) {
            _products = item;
            break;
          }
        }

        debugPrint(_products.toString());
      });
    } catch (e) {
      debugPrint('Error loading or decoding JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String price = '';
    num? amount = _products['product_price']?['amount'];

    if (amount != null) {
      price = amount.toCurrency$();
    }
    List productDetails = [];
    if (_products['product_details'] != null) {
      productDetails = _products['product_details'];
    }

    List<Color> productColors = [];
    for (var detail in productDetails) {
      String hexColor = detail["color"];
      Color dynamicColor = Color(int.parse("0xFF$hexColor"));
      productColors.add(dynamicColor);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: '${_products['product_name']}'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 455,
                width: context.screenWidth,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      margin: const EdgeInsets.only(left: 64),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(42),
                          bottomLeft: Radius.circular(42),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${_products['product_image']}'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 64,
                        height: (50 * productDetails.length.toDouble()) +
                            (16 + 16 * productDetails.length.toDouble()),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(64 / 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            productDetails.length,
                            (index) => InkWell(
                              onTap: () {
                                _buildShowModalBottomSheet(productDetails);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.only(
                                    bottom: 16, top: index == 0 ? 16 : 0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: CircleAvatar(
                                  radius: 28.0,
                                  backgroundColor: Color(int.parse(
                                      "0xFF${productDetails[index]['color']}")),
                                  // DetailsColor.values[index].color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_products['product_name']}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF303030),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Color(0xFF303030),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    16.height,
                    Text(
                      '${_products['product_description']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF606060),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: kBottomNavigationBarHeight + 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        backgroundColor: AppColors.background,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(),
        ),
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(bottom: 32),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedBookmark = !selectedBookmark;
                      AppPrefs.saveJsonToSharedPreferences(_products);
                    });
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-1, 4),
                          color: const Color(0xFF8A959E).withOpacity(0.25),
                          blurRadius: 40,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: selectedBookmark
                        ? AppIcons.activeBookmark
                        : AppIcons.unactiveBookmark,
                  ),
                ),
                16.width,
                Flexible(
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: AppElevatedButtonWidget(
                      onPressed: () {},
                      radius: 8,
                      elevation: 8,
                      shodowColor: const Color(0xFF303030).withOpacity(0.25),
                      child: 'Order'.asTitleSmall(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _buildShowModalBottomSheet(List productDetails) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  'Macramé threads'.asTitleSmall(
                    fontWeight: FontWeight.w600,
                  ),
                  12.height,
                  const Divider(
                    thickness: 0.2,
                    height: 1,
                    color: AppColors.darkGrey,
                  ),
                  ListView.separated(
                    itemCount: productDetails.length,
                    shrinkWrap: true,
                    separatorBuilder: (contex, index) {
                      return const Divider(
                        thickness: 0.2,
                        height: 1,
                        color: AppColors.darkGrey,
                      );
                    },
                    itemBuilder: (contex, index) {
                      final details = productDetails[index];
                      return Container(
                        height: 70,
                        padding: const EdgeInsets.only(top: 12),
                        child: ListTile(
                            onTap: () => setState(() {
                                  selectedIndex = details;
                                  contex.pop();
                                }),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            leading: details?['detail_image'] != null
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      details?['detail_image'],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            title: details['detail_title']
                                .toString()
                                .asSubtitleBig(),
                            trailing: SizedBox(
                              height: 20,
                              child: selectedIndex == details
                                  ? AppIcons.activeCheck
                                  : null,
                            )),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
