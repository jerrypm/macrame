import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/common/utils/app_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/app_elevated_button_widget.dart';
import '../../../components/app_text_form_field_widget.dart';
import '../../../config/routers/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';
import '../widgets/authentication_social_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isObscureText = true;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  void setObscureText() {
    isObscureText = !isObscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: 'Welcome Back'.asTitleBig(
                        color: AppColors.deepBlue,
                      ),
                    ),
                    32.height,
                    ..._buildEmailField(),
                    20.height,
                    ..._buildPasswordField(),
                    12.height,
                    Align(
                      alignment: Alignment.centerRight,
                      child: 'Forgot your password?'.asSubtitleNormal(
                        color: AppColors.spanishGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: AppElevatedButtonWidget(
                        onPressed: () {
                          if (_validateLogin()) {
                            context.showErrorSnackbar('Message');
                          } else {
                            context.goNamed(AppRoutes.home.name);
                          }
                        },
                        radius: 8,
                        elevation: 4,
                        backgroundColor: _validateLogin()
                            ? AppColors.spanishGray
                            : AppColors.arsenic,
                        child: 'Log In'.asSubtitleBig(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    16.height,
                    if (MediaQuery.of(context).viewInsets.bottom == 0)
                      Column(
                        children: [
                          20.height,
                          AuthenticationSocialWidget(
                            onGoogle: () {},
                            onFacebook: () {},
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Don't have an account yet?".asSubtitleNormal(
                                color: AppColors.deepBlue,
                                fontWeight: FontWeight.w400,
                              ),
                              4.width,
                              InkWell(
                                onTap: () =>
                                    context.pushNamed(AppRoutes.register.name),
                                child: "Sign Up".asSubtitleNormal(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          16.height,
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateLogin() {
    bool isEmailEmpty = emailController.text.isEmpty;
    bool isPasswordEmpty = passwordController.text.isEmpty;

    return isEmailEmpty || isPasswordEmpty;
  }

  List<Widget> _buildEmailField() {
    return [
      'E-mail'.asSubtitleNormal(
        color: AppColors.darkGrey,
        fontWeight: FontWeight.w500,
      ),
      8.height,
      SizedBox(
        height: 48,
        child: AppTextFormFieldWidget(
          filled: true,
          onTap: () => setState(() {
            _focusNodeEmail.hasFocus;
          }),
          controller: emailController,
          fillColor: AppColors.accent,
          focusNode: _focusNodeEmail,
          hintText: 'Enter your e-mail here',
          onChanged: (p0) {
            setState(() {
              _validateLogin();
            });
          },
          prefixIcon: Container(
            padding: const EdgeInsets.all(14),
            child: _focusNodeEmail.hasFocus
                ? AppIcons.activeEmail
                : AppIcons.unactiveEmail,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildPasswordField() {
    return [
      'Password'.asSubtitleNormal(
        color: AppColors.darkGrey,
        fontWeight: FontWeight.w500,
      ),
      8.height,
      SizedBox(
        height: 48,
        child: AppTextFormFieldWidget(
          filled: true,
          fillColor: Colors.white,
          controller: passwordController,
          onTap: () => setState(() {
            _focusNodePassword.hasFocus;
          }),
          hintText: 'Place the password here',
          obscureText: isObscureText,
          focusNode: _focusNodePassword,
          prefixIcon: Container(
            padding: const EdgeInsets.all(14),
            child: _focusNodePassword.hasFocus
                ? AppIcons.activeLock
                : AppIcons.unactiveLock,
          ),
          onChanged: (p0) {
            setState(() {
              _validateLogin();
            });
          },
          suffixIcon: InkWell(
            onTap: setObscureText,
            child: Container(
              padding: const EdgeInsets.all(14),
              child:
                  isObscureText ? AppIcons.activeEyes : AppIcons.unactiveEyes,
            ),
          ),
        ),
      ),
    ];
  }
}
