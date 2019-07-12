import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'checkout.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 4.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
String selectedUrl = 'https://ravesandbox.flutterwave.com/pay/kkf2j4gybzqr';

class PayStand extends StatefulWidget {
  @override
  _PayStandState createState() => _PayStandState();
}

class _PayStandState extends State<PayStand> {


  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.launch(selectedUrl);
  }


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: AppBar(
        title: const Text('Payment'),
      ),

      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      enableAppScheme: true,



    );
  }
}