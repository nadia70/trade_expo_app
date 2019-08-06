import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'checkout.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 4.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
String selectedUrl = 'https://rave.flutterwave.com/pay/rtifegdz';

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
    );
  }
}
