import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/common/utils/app_alert_dialog.dart';
import 'package:macrame_app/app/components/app_elevated_button_widget.dart';
import 'package:macrame_app/app/config/routers/app_routes.dart';
import 'package:macrame_app/app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/app_icons.dart';
import '../extensions/profile_menu_extensions.dart';
import '../widgets/profile_user_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: 'Profile'.asTitleSmall(
          color: const Color(0xFF303030),
          fontWeight: FontWeight.w700,
        ),
        actions: [
          InkWell(
            onTap: () => context.showDialogWidget(
              dialogContent: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: 'Are you sure want to Log out ?'.asSubtitleBig(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              actions: [
                SizedBox(
                  height: 30,
                  child: AppElevatedButtonWidget(
                    backgroundColor: AppColors.error,
                    radius: 8,
                    child: 'Yes'.asSubtitleBig(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {},
                  ),
                ),
                50.width,
                SizedBox(
                  height: 30,
                  child: AppElevatedButtonWidget(
                    backgroundColor: AppColors.spanishGray,
                    radius: 8,
                    child: 'No'.asSubtitleBig(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            child: SizedBox(
              height: 20,
              width: 20,
              child: AppIcons.activeLogout,
            ),
          ),
          16.width,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                const ProfileUserWidget(),
                24.height,
                ListView.builder(
                  itemCount: ProfileMenu.values.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final menu = ProfileMenu.values[index];
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
                        onTap: () {
                          switch (menu) {
                            case ProfileMenu.orders:
                              context.pushNamed(AppRoutes.myOrders.name);
                              break;
                            case ProfileMenu.reviews:
                              context.goNamed(AppRoutes.myReviews.name);
                              break;
                            case ProfileMenu.settings:
                              context.goNamed(AppRoutes.settings.name);
                              break;
                            default:
                          }
                        },
                        contentPadding: EdgeInsets.zero,
                        title: menu.name.asTitleSmall(
                          fontWeight: FontWeight.w700,
                        ),
                        subtitle: menu.subtitle().asSubtitleNormal(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF808080),
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
      ),
    );
  }
}
