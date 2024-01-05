import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViews extends StatefulWidget {
  final String? url;

  final String? title;

  const WebViews({Key? key, this.url, this.title}) : super(key: key);

  @override
  State<WebViews> createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }

  Future<bool> onBackPressed() async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false;
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: '${widget.title}'.asTitleSmall(
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
        body: Stack(
          children: [
            WebViewWidget(
              controller: webViewController,
            ),
            if (isLoading) const CupertinoActivityIndicator(),
          ],
        ),
      );
    }
  }
}
