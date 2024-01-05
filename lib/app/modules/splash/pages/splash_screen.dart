import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_elevated_button_widget.dart';
import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_logos.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLogin = false;

  @override
  void initState() {
    super.initState();
    showButton();
  }

  void showButton() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLogin = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Stack(
          children: [
            Positioned(
              left: -(context.screenWidth / 2) - kToolbarHeight + 50,
              child: Opacity(
                opacity: 0.1,
                child: AppLogos.logoLarge,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 98,
                    width: 98,
                    child: AppLogos.logoMini,
                  ),
                  16.height,
                  const Text(
                    'Welcome to \nmacramé',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.arsenic,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  32.height,
                  'Macrame Masterpieces Await You!'.asTitleSmall(
                    fontWeight: FontWeight.w400,
                    color: AppColors.spanishGray,
                  ),
                  if (isLogin == false) 148.height else 50.height,
                  const Spacer(),
                  if (isLogin)
                    Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: AppElevatedButtonWidget(
                        onPressed: () => context.goNamed(AppRoutes.login.name),
                        radius: 8,
                        elevation: 4,
                        child: 'Let\' start'.asSubtitleBig(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (isLogin) 60.height
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
