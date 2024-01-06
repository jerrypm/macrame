import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app/config/routers/app_router.dart';
import 'app/config/themes/app_theme.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsFlutterBinding.ensureInitialized();
  try {
    runApp(const MyApp());
  } catch (e) {
    runApp(MyAppStartupErrorWidget(error: e));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // hide debug mode
      theme: AppTheme.defaults(),
      routerConfig: AppRouter.router(),
    );
  }
}

class MyAppStartupErrorWidget extends StatelessWidget {
  final dynamic error;

  const MyAppStartupErrorWidget({Key? key, required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Error during app startup:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
