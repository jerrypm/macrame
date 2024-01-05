import 'package:macrame_app/app/common/extensions/app_carrency_extension.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  List _orders = [];

  @override
  void initState() {
    super.initState();
    ordersJson();
  }

  Future<void> ordersJson() async {
    final String response =
        await rootBundle.loadString('assets/json/orders.json');
    final data = await json.decode(response);

    setState(() {
      _orders = data['orders'];
    });
  }

  List<String> getStatusList() {
    List<String> statusList = [];
    for (var order in _orders) {
      if (!statusList.contains(order['status'])) {
        statusList.add(order['status']);
      }
    }
    return statusList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getStatusList().length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: 'My Orders'.asTitleSmall(
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
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: getStatusList().map((status) {
              return Tab(
                text: status[0].toUpperCase() + status.substring(1),
              );
            }).toList(),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: getStatusList().map((status) {
              return OrderTab(status: status, orders: _orders);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class OrderTab extends StatelessWidget {
  final String status;
  final List orders;

  const OrderTab({Key? key, required this.status, required this.orders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List filteredOrders =
        orders.where((order) => order['status'] == status).toList();

    return ListView.builder(
      itemCount: filteredOrders.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        num totalPrice = filteredOrders[index]['total_price'];
        return InkWell(
          onTap: () => context.pushNamed(
            AppRoutes.orderDetails.name,
            pathParameters: {
              'order_id': filteredOrders[index]['order_id'].toString(),
            },
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                16.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Order No${filteredOrders[index]['order_id']}",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${filteredOrders[index]['date']}",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: AppColors.spanishGray,
                        ),
                      ),
                    ],
                  ),
                ),
                8.height,
                const Divider(thickness: 0.5),
                8.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Quantity:",
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.spanishGray,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${filteredOrders[index]['quantity']}',
                                  style: const TextStyle(
                                    color: AppColors.raisinBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            status[0].toUpperCase() + status.substring(1),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: getColor(),
                            ),
                          ),
                        ],
                      ),
                      16.height,
                      Text.rich(
                        TextSpan(
                          text: "Total Amount: ",
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.spanishGray,
                          ),
                          children: [
                            TextSpan(
                              text: totalPrice.toCurrencyRP(),
                              style: const TextStyle(
                                color: AppColors.raisinBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                16.height,
              ],
            ),
          ),
        );
      },
    );
  }

  getColor() {
    switch (status) {
      case 'delivered':
        return const Color(0xFF66C38D);
      case 'processing':
        return const Color(0xFFCE8A2A);
      case 'canceled':
        return const Color(0xFFEF8B8B);
      default:
    }
  }
}
