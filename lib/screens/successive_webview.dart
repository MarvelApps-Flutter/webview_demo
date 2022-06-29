import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_module/constants/text_constants.dart';

class SuccessiveWebsiteScreen extends StatefulWidget {
  const SuccessiveWebsiteScreen({Key? key}) : super(key: key);

  @override
  State<SuccessiveWebsiteScreen> createState() =>
      _SuccessiveWebsiteScreenState();
}

class _SuccessiveWebsiteScreenState extends State<SuccessiveWebsiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(TextConstants.appBarTitle),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const WebView(
          initialUrl: TextConstants.successiveWebUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
