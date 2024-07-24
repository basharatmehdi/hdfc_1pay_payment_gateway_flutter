import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onepay_test/pages/success.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:onepay_test/services/transaction_data.dart';
import 'package:onepay_test/utils/encryption.dart';
import 'dart:convert';

class WebViewApp extends StatefulWidget {
  final Map<String, dynamic> data;

  const WebViewApp({super.key, required this.data});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  late TransactionData td;
  late Map<String, dynamic> data;

  checkUrlState(String? url) async => {
        log(url.toString()),
        if (url!.contains('example')) // some part of your registered return url
          {
            td = TransactionData(
                details: data,
                merchantId: data["merchantId"].toString(),
                txnId: data["txnId"].toString()),
            await td.getData(),
            if (mounted)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => TransactionResponsePage(
                      pGTransaction: td.pGTransaction,
                    ),
                  ),
                )
              }
          }
      };

  @override
  void initState() {
    super.initState();
    data = widget.data;
    String enc = EncryptionUtils(
            secretKey: dotenv.env['secretKey']!, iv: dotenv.env["iv"]!)
        .encryptText(jsonEncode(data));
    String html = loadHTML(dotenv.env['merchantID']!, enc);
    log(html);
    controller = WebViewController()..loadHtmlString(html);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onUrlChange: (urlChange) => checkUrlState(urlChange.url),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '1 Pay Test',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

String loadHTML(String merchantId, String enc) {
  // all you need to replace url in action with live url after completion of test
  // live url: https://pay.1pay.in/payment/payprocessorV2
  return r'''
      <html>
        <body onload="document.f.submit();">
          <form id="f" name="f" method="post" action="https://pa-preprod.1pay.in/payment/payprocessorV2">
            <input type="hidden" name="merchantId" value="''' +
      merchantId +
      r'''">
            <input type="hidden" name="reqData" value="''' +
      enc +
      r'''">
          </form>
        </body>
      </html>
    ''';
}
