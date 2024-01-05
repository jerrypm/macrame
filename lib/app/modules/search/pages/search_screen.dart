import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_card_product_widget.dart';
import '../../../components/app_text_form_field_widget.dart';
import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';
import '../extensions/search_extensions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  String selectedFilter = SearchByCatalog.wallHanging.name;
  late FocusNode _focusNodeSearch;

  @override
  void initState() {
    super.initState();
    _focusNodeSearch = FocusNode();
    productJson();
  }

  @override
  void dispose() {
    _focusNodeSearch.dispose();
    super.dispose();
  }

  List _products = [];
  List _filteredProducts = [];

  Future<void> productJson() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final data = await json.decode(response);

    setState(() {
      _products = data['products'];
      _filteredProducts = List.from(_products);
    });
  }

  void _searchByName(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) => product['product_name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _searchByCatalog(String query) {
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
        title: 'Search'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 48,
                    child: AppTextFormFieldWidget(
                      fillColor: Colors.white,
                      controller: searchController,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      onTap: () => setState(() {
                        _focusNodeSearch.hasFocus;
                      }),
                      filled: true,
                      focusNode: _focusNodeSearch,
                      onChanged: (value) {
                        setState(() {
                          searchController.text = value;
                        });
                        _searchByName(value);
                      },
                      hintText: 'Search items',
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(14),
                        child: _focusNodeSearch.hasFocus
                            ? AppIcons.unactiveSearch
                            : AppIcons.unactiveSearch,
                      ),
                    ),
                  ),
                ),
                12.width,
                InkWell(
                  child: Container(
                    height: 48,
                    width: 48,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    child: AppIcons.unactiveFilter,
                  ),
                  onTap: () {
                    showModalBottomSheet(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  'Filter by catalog'.asTitleSmall(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  12.height,
                                  const Divider(
                                    thickness: 0.2,
                                    height: 1,
                                    color: AppColors.darkGrey,
                                  ),
                                  ListView.separated(
                                    itemCount: SearchByCatalog.values.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (contex, index) {
                                      return const Divider(
                                        thickness: 0.2,
                                        height: 1,
                                        color: AppColors.darkGrey,
                                      );
                                    },
                                    itemBuilder: (contex, index) {
                                      final category =
                                          SearchByCatalog.values[index];
                                      return ListTile(
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = category.name;
                                            });
                                            _searchByCatalog(
                                                category.catalogType);

                                            contex.pop();
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          title: category.name.asSubtitleBig(),
                                          trailing: SizedBox(
                                            height: 20,
                                            child:
                                                selectedFilter == category.name
                                                    ? AppIcons.activeCheck
                                                    : null,
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (searchController.text.isEmpty) 20.height,
              if (searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: 'Search for profuct "${searchController.text}"'
                      .asSubtitleBig(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (searchController.text.isNotEmpty) 16.height,
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65,
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 16,
                  // childAspectRatio: 16 / 5,
                  // crossAxisCount: 1,
                  // mainAxisSpacing: 14,
                  // crossAxisSpacing: 16,
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
                  // return const SearchCardProductWidget();
                },
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
