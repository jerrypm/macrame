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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  bool isObscureText = true;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodeFullname;
  late FocusNode _focusNodePassword;
  String errorPassword = '';

  @override
  void initState() {
    super.initState();
    _focusNodeFullname = FocusNode();
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeFullname.dispose();
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
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: 'Create an account'.asTitleBig(
                      color: AppColors.deepBlue,
                    ),
                  ),
                  32.height,
                  ..._buildUsernameField(),
                  20.height,
                  ..._buildEmailField(),
                  20.height,
                  ..._buildPasswordField(),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppElevatedButtonWidget(
                      onPressed: () {
                        if (_validateRegister()) {
                          context.showErrorSnackbar('Message');
                        } else {
                          context.goNamed(AppRoutes.home.name);
                        }
                      },
                      radius: 6,
                      elevation: 4,
                      backgroundColor: _validateRegister()
                          ? AppColors.spanishGray
                          : AppColors.arsenic,
                      child: 'Register'.asSubtitleBig(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  12.height,
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
                            "Already have an account?".asSubtitleNormal(
                              color: AppColors.deepBlue,
                              fontWeight: FontWeight.w400,
                            ),
                            4.width,
                            InkWell(
                              onTap: () => context.pop(),
                              child: "Sign In".asSubtitleNormal(
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
    );
  }

  bool _validateRegister() {
    bool isEmailEmpty = emailController.text.isEmpty;
    bool isPasswordEmpty = passwordController.text.isEmpty;
    bool isUsernameEmpty = usernameController.text.isEmpty;
    return isEmailEmpty || isPasswordEmpty || isUsernameEmpty;
  }

  List<Widget> _buildUsernameField() {
    return [
      'Fullname'.asSubtitleNormal(
        color: AppColors.darkGrey,
        fontWeight: FontWeight.w500,
      ),
      8.height,
      AppTextFormFieldWidget(
        filled: true,
        onTap: () => setState(() {
          _focusNodeFullname.hasFocus;
        }),
        onChanged: (p0) {
          setState(() {
            _validateRegister();
          });
        },
        fillColor: Colors.white,
        focusNode: _focusNodeFullname,
        controller: usernameController,
        hintText: 'Enter your fullname here',
        prefixIcon: Container(
          padding: const EdgeInsets.all(14),
          child: _focusNodeFullname.hasFocus
              ? AppIcons.activeUsername
              : AppIcons.unactiveUsername,
        ),
      ),
    ];
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
          onChanged: (p0) {
            setState(() {
              _validateRegister();
            });
          },
          fillColor: Colors.white,
          controller: emailController,
          focusNode: _focusNodeEmail,
          hintText: 'Enter your e-mail here',
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
        color: errorPassword.isNotEmpty ? AppColors.error : AppColors.darkGrey,
        fontWeight: FontWeight.w500,
      ),
      8.height,
      SizedBox(
        height: 48,
        child: AppTextFormFieldWidget(
          filled: true,
          fillColor: Colors.white,
          controller: passwordController,
          style: errorPassword.isNotEmpty
              ? const TextStyle(color: AppColors.error)
              : null,
          onTap: () => setState(() {
            _focusNodePassword.hasFocus;
          }),
          hintText: 'Place the password here',
          obscureText: isObscureText,
          focusNode: _focusNodePassword,
          onChanged: (value) {
            setState(() {
              _validateRegister();
            });
            if (value.length < 8) {
              setState(() {
                errorPassword = 'At least 8 characters';
              });
            } else {
              setState(() {
                errorPassword = '';
              });
            }
          },
          error: errorPassword.isNotEmpty ? const SizedBox.shrink() : null,
          prefixIcon: Container(
            padding: const EdgeInsets.all(14),
            child: errorPassword.isNotEmpty
                ? AppIcons.errorLock
                : _focusNodePassword.hasFocus
                    ? AppIcons.activeLock
                    : AppIcons.unactiveLock,
          ),
          suffixIcon: InkWell(
            onTap: setObscureText,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: errorPassword.isNotEmpty
                  ? AppIcons.activeAlert
                  : isObscureText
                      ? AppIcons.activeEyes
                      : AppIcons.unactiveEyes,
            ),
          ),
        ),
      ),
      4.height,
      if (errorPassword.isNotEmpty)
        errorPassword.asSubtitleNormal(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
    ];
  }
}
