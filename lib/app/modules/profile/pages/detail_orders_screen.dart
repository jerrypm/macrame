import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_elevated_button_widget.dart';
import '../../../config/themes/app_colors.dart';

class DetailsOrdersScreen extends StatefulWidget {
  const DetailsOrdersScreen({super.key, this.orderId});

  final int? orderId;

  @override
  State<DetailsOrdersScreen> createState() => _DetailsOrdersScreenState();
}

class _DetailsOrdersScreenState extends State<DetailsOrdersScreen> {
  Map<String, dynamic> _order = {};

  @override
  void initState() {
    super.initState();
    ordersJson();
  }

  Future<void> ordersJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/orders.json');
      final data = await json.decode(response);

      setState(() {
        List<dynamic> items = data['orders'];

        for (var item in items) {
          if (item['order_id'] == widget.orderId) {
            _order = item;
            break;
          }
        }

        debugPrint(_order.toString());
      });
    } catch (e) {
      debugPrint('Error loading or decoding JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: 'Detail Order'.asTitleSmall(
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildOrderItems(),
              const Divider(thickness: 0.5),
              _buildStatusOrder(),
              const Divider(thickness: 0.5),
              _buildPaymentDetails(),
            ],
          ),
        ),
      ),
      bottomSheet: _order['status'] == 'delivered'
          ? BottomSheet(
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
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: AppElevatedButtonWidget(
                      onPressed: () {
                        _buildShowModalBottomSheet(context);
                      },
                      radius: 8,
                      elevation: 8,
                      shodowColor: const Color(0xFF303030).withOpacity(0.25),
                      child: 'Write Review'.asTitleSmall(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }

  Future<dynamic> _buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: keyboardHeight,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Write Review'.asTitleSmall(
                  fontWeight: FontWeight.w400,
                ),
                12.height,
                SizedBox(
                  height: (187),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    maxLength: null,
                    cursorColor: AppColors.arsenic,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      isDense: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(12),
                      hintText:
                          "Whether you're a seasoned Macrame enthusiast or a newcomer to the art, our collection caters to all skill levels",
                      hintStyle: const TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
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
                    ),
                  ),
                ),
                24.height,
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: AppElevatedButtonWidget(
                    onPressed: () {
                      context.pop();
                    },
                    radius: 8,
                    elevation: 8,
                    shodowColor: const Color(0xFF303030).withOpacity(0.25),
                    child: 'Publish Review'.asTitleSmall(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                32.height,
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _buildPaymentDetails() {
    num shippingCost = 0;
    num productPrice = 0;
    num totalPrice = 0;
    if (_order['shipping_cost'] != null) shippingCost = _order['shipping_cost'];
    if (_order['product_price'] != null) productPrice = _order['product_price'];
    if (_order['total_price'] != null) totalPrice = _order['total_price'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Payment Details'.asSubtitleBig(
                fontWeight: FontWeight.w700,
              ),
              8.height,
              Row(
                children: [
                  'Shipping cost'.asSubtitleBig(
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  shippingCost.toCurrency$().asSubtitleBig(),
                ],
              ),
              8.height,
              Row(
                children: [
                  'Product price'.asSubtitleBig(
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  productPrice.toCurrency$().asSubtitleBig(),
                ],
              ),
            ],
          ),
          8.height,
          const Divider(thickness: 0.5),
          8.height,
          Row(
            children: [
              'Total purchase'.asSubtitleBig(
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              totalPrice.toCurrency$().asSubtitleBig(
                    fontWeight: FontWeight.w700,
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildStatusOrder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Text(
            "Status:",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.spanishGray,
            ),
          ),
          const Spacer(),
          Text(
            _order['status'].toString()[0].toUpperCase() +
                _order['status'].toString().substring(1),
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: getColor(),
            ),
          ),
        ],
      ),
    );
  }

  getColor() {
    switch (_order['status']) {
      case 'delivered':
        return const Color(0xFF66C38D);
      case 'processing':
        return const Color(0xFFCE8A2A);
      case 'canceled':
        return const Color(0xFFEF8B8B);
      default:
    }
  }

  ListView _buildOrderItems() {
    return ListView.builder(
      itemCount: _order['product_items']?.length ?? 0,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var item = _order['product_items'][index];
        num a = item['amount'];
        var price = a.toCurrency$();
        return Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(item['image_url']),
                  ),
                ),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '${item['title']}'.asSubtitleBig(
                    color: const Color(0xFF606060),
                    fontWeight: FontWeight.w600,
                  ),
                  8.height,
                  price.asSubtitleBig(
                    fontWeight: FontWeight.w700,
                  ),
                  12.height,
                  'x ${item['items']}'.asSubtitleBig(
                    color: const Color(0xFF606060),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
