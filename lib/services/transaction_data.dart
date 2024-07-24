import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TransactionData {
  String txnId, merchantId;
  Map<String, dynamic> details;
  Map<dynamic, dynamic> pGTransaction = {};
  TransactionData(
      {required this.merchantId, required this.txnId, required this.details});
  Future<void> getData() async {
    //replace "pa-preprod.1pay.in" with "pay.1pay.in"
    // or uncomment live url and comment test url
    try {
      Response res = await post(Uri.https(
        'pa-preprod.1pay.in',
        // 'pay.1pay.in',
        '/payment/getTxnDetails',
        {"merchantId": merchantId, "txnId": txnId},
        // details,
      ));
      Map data = jsonDecode(res.body);
      log(data.toString());
      pGTransaction = data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
