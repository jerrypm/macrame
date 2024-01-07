import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:macrame_app/app/components/app_elevated_button_widget.dart';
import 'package:macrame_app/app/components/app_text_form_field_widget.dart';
import 'package:macrame_app/app/config/themes/app_icons.dart';

import '../../../config/themes/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();

  bool isObscureText = true;
  late FocusNode _focusNodeEmail;

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    super.dispose();
  }

  void setObscureText() {
    isObscureText = !isObscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  64.height,
                  'Forgot Password?'.asTitleSemiBig(
                    color: AppColors.deepBlue,
                  ),
                  12.height,
                  'Enter your registered email address on Macrame app to create a password'
                      .asSubtitleBig(
                    color: AppColors.spanishGray,
                  ),
                  40.height,
                  ..._buildEmailField(),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppElevatedButtonWidget(
                      onPressed: () {
                        // Action here
                      },
                      radius: 8,
                      elevation: 4,
                      backgroundColor: _validatePage()
                          ? AppColors.spanishGray
                          : AppColors.arsenic,
                      child: 'Continue'.asSubtitleBig(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validatePage() {
    bool isEmailEmpty = emailController.text.isEmpty;
    return isEmailEmpty;
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
              _validatePage();
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
}
