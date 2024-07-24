import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionResponsePage extends StatelessWidget {
  final Map<dynamic, dynamic> pGTransaction;

  const TransactionResponsePage({
    super.key,
    required this.pGTransaction,
  });
  @override
  Widget build(BuildContext context) {
    log(pGTransaction.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Transaction Response'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Success
            if (pGTransaction["trans_status"] == 'Ok') ...[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  children: <Widget>[
                    Text(
                      'Recharge successful!',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/success.png',
                height: 100.0,
              ),
            ]
            // Failure
            else if (pGTransaction["trans_status"] == 'F') ...[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  children: <Widget>[
                    Text(
                      'Transaction failed',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Please try again.',
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/failed.svg',
                height: 100.0,
              ),
            ],
            Text(
              ' Merchant Order Number : ${pGTransaction["txn_id"]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Merchant Id: ${pGTransaction['merchant_id']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'PG Transaction Ref # : ${pGTransaction['pg_ref_id']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Response Date Time : ${pGTransaction['resp_date_time']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Transaction Status : ${pGTransaction['trans_status']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Transaction Amount : ${pGTransaction['txn_amount']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Response Transaction Code : ${pGTransaction['resp_code']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Response Message :	${pGTransaction['resp_message']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Customer Email Id : ${pGTransaction['cust_email_id']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Customer Phone No. : ${pGTransaction['cust_mobile_no']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Bank Reference Number : ${pGTransaction['bank_ref_id']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Transaction Date :	${pGTransaction['txn_date_time']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Payment mode : ${pGTransaction['payment_mode']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/"),
              child: const Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }
}
