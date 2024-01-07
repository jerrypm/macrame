import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/config/routers/app_routes.dart';
import 'package:macrame_app/app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool statusChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Profile'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Notifications'.asSubtitleBig(
                fontWeight: FontWeight.w700,
                color: AppColors.spanishGray,
              ),
              12.height,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8A959E).withOpacity(0.1),
                      offset: const Offset(0, 7),
                      blurRadius: 40,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: 'Delivery status changes'.asSubtitleBig(
                    fontWeight: FontWeight.w700,
                  ),
                  trailing: Switch(
                    value: statusChange,
                    activeColor: AppColors.arsenic,
                    inactiveThumbColor: AppColors.spanishGray,
                    inactiveTrackColor: Colors.grey[200],
                    onChanged: (value) {
                      setState(() {
                        statusChange = !statusChange;
                      });
                    },
                  ),
                ),
              ),
              'Help Center'.asSubtitleBig(
                fontWeight: FontWeight.w700,
                color: AppColors.spanishGray,
              ),
              12.height,
              ListView.builder(
                itemCount: SettingsCategory.values.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final menu = SettingsCategory.values[index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8A959E).withOpacity(0.1),
                          offset: const Offset(0, 7),
                          blurRadius: 40,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () => menu.webview(context),
                      contentPadding: EdgeInsets.zero,
                      title: menu.name.asSubtitleBig(
                        fontWeight: FontWeight.w700,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        size: 24.0,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SettingsCategory {
  faq,
  contactUs,
  privacyAndPolicy,
}

extension SettingsCategoryExtensions on SettingsCategory {
  String get name {
    switch (this) {
      case SettingsCategory.faq:
        return 'FAQ';
      case SettingsCategory.contactUs:
        return 'Contact Us';
      case SettingsCategory.privacyAndPolicy:
        return 'Privacy and policy';
      default:
        return '';
    }
  }

  void webview(BuildContext context) {
    switch (this) {
      case SettingsCategory.faq:
        context.pushNamed(AppRoutes.webViews.name, pathParameters: {
          'url': 'https://www.testingtime.com/en/faq-testusers/'
        }, extra: {
          'title': 'FAQ'
        });
        break;
      case SettingsCategory.contactUs:
        context.pushNamed(AppRoutes.webViews.name, pathParameters: {
          'url': 'https://www.testingtime.com/en/faq-testusers/'
        }, extra: {
          'title': 'Contact Us'
        });
        break;
      case SettingsCategory.privacyAndPolicy:
        context.pushNamed(AppRoutes.webViews.name, pathParameters: {
          'url': 'https://www.testingtime.com/en/faq-testusers/'
        }, extra: {
          'title': 'Privacy and Policy'
        });
        break;
      default:
    }
  }
}
