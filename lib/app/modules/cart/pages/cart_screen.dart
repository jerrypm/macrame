import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/app_elevated_button_widget.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final String phoneNumber = '+6285959327933';
  final String message = 'Hello, this is a pre-filled message!';

  Future<void> launchWhatsApp() async {
    String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await canLaunchUrl(Uri.parse(url));
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: 'Cart'.asTitleSmall(
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
      ),
      body: ListView.builder(
        itemCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://raw.githubusercontent.com/jerrypm/nextproject/master/macrame1.png'),
                    ),
                  ),
                ),
                16.width,
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Leaf Wall Hanging'.asSubtitleBig(
                            color: AppColors.spanishGray,
                          ),
                          4.height,
                          'Rp 120.000'.asTitleSmall(
                            fontWeight: FontWeight.w700,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 24.0,
                                ),
                              ),
                              16.width,
                              const Text(
                                '01',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              16.width,
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: AppIcons.activeClear,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      'Total:'.asTitleSmall(
                        color: AppColors.darkGrey,
                      ),
                      const Spacer(),
                      const Text(
                        'Rp 1.560.000',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                16.height,
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: AppElevatedButtonWidget(
                    onPressed: () async {
                      launchWhatsApp();
                    },
                    radius: 8,
                    elevation: 8,
                    shodowColor: const Color(0xFF303030).withOpacity(0.25),
                    child: 'Check Out'.asTitleSmall(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
