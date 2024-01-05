import 'dart:convert';

import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List _promo = [];
  List _tansaction = [];

  @override
  void initState() {
    super.initState();
    ordersJson();
  }

  Future<void> ordersJson() async {
    final String response =
        await rootBundle.loadString('assets/json/promo.json');
    final data = await json.decode(response);

    setState(() {
      _promo = data['promo'];
      _tansaction = data['transaction'];
    });
    debugPrint(_promo.toString());
    debugPrint(_tansaction.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: 'Notification'.asTitleSmall(
            color: const Color(0xFF303030),
            fontWeight: FontWeight.w700,
          ),
          actions: const [],
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          bottom: const TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            splashFactory: NoSplash.splashFactory,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Promo'),
              Tab(text: 'Transaction'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildPromoViews(),
              _buildTransactionViews(),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildPromoViews() {
    return ListView.separated(
      itemCount: _promo.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(thickness: 0.4);
      },
      itemBuilder: (BuildContext context, int index) {
        var item = _promo[index];
        return SizedBox(
          height: 289,
          child: Column(
            children: [
              16.height,
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      item['image_url'],
                    ),
                  ),
                ),
              ),
              16.height,
              item['description'].toString().asSubtitleSmall(),
              8.height,
            ],
          ),
        );
      },
    );
  }

  ListView _buildTransactionViews() {
    return ListView.separated(
      itemCount: _tansaction.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      separatorBuilder: (context, index) {
        return const Divider(thickness: 0.4);
      },
      itemBuilder: (BuildContext context, int index) {
        var item = _tansaction[index];
        return SizedBox(
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      item['image_url'],
                    ),
                  ),
                ),
              ),
              16.width,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    item['title'].toString().asSubtitleNormal(
                          fontWeight: FontWeight.w700,
                        ),
                    8.height,
                    item['description'].toString().asSubtitleSmall(
                          color: Colors.grey,
                        ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
