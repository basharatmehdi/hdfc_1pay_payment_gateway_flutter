import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onepay_test/pages/web_view.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State createState() {
    return _MyForm();
  }
}

class _MyForm extends State {
  TextEditingController midController =
      TextEditingController(text: dotenv.env["merchantID"]);
  TextEditingController apiKeyController =
      TextEditingController(text: dotenv.env["secretKey"]);
  TextEditingController txnIdController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  bool _validate = false;

  bool isTwoDecimalFloat(String input) {
    // Define a regular expression pattern for a float with exactly two decimal places
    final RegExp regex = RegExp(r'^\d+\.\d{2}$');

    // Use the pattern to match the input
    return regex.hasMatch(input);
  }

  void generateTxnId() {
    final random = Random();
    const min = 10000000;
    const max = 99999999;
    final randomNumber = min + random.nextInt(max - min + 1);
    txnIdController.text = randomNumber.toString();
  }

  void generateAmount() {
    double min = 1.0; // Minimum value
    double max = 100.0; // Maximum value

    // Generate a random number between min and max with two decimal places
    double randomDouble =
        (Random().nextDouble() * (max - min) + min).toDouble();
    randomDouble = double.parse(randomDouble.toStringAsFixed(2));
    amtController.text = randomDouble.toString();
  }

  void updateValues() {
    Map<String, String> data = {
      "merchantId": "",
      "apiKey": "",
      "txnId": "",
      "amount": "",
      "dateTime": "2023-10-02 18:16:29",
      "custMail": "test@test.com",
      "custMobile": "9999999999", // customer mobile (optional)
      "udf1": "NA",
      "udf2": "NA",
      "returnURL":
          "https://www.example.com/", //add your return url registered with 1pay
      "productId": "DEFAULT",
      "channelId": "0",
      "isMultiSettlement": "0",
      "txnType": "DIRECT",
      "instrumentId": "NA",
      "Rid": "R0000422", // your Rid
      "ResellerTxnId": "NA",
      "udf3": "NA",
      "udf4": "NA",
      "udf5": "NA",
      "cardDetails": "NA",
      "cardType": "NA"
    };
    setState(() {
      data['merchantId'] =
          midController.text; //the one which you get from 1pay admin panel
      data['apiKey'] =
          apiKeyController.text; //the one which you get from 1pay admin panel
      data["txnId"] =
          txnIdController.text; // trxn id and amount will be generated
      if (isTwoDecimalFloat(amtController.text)) {
        data["amount"] = amtController.text;
        _validate = false;
      } else {
        _validate = true;
      }
    });
    if (!_validate) {
      openWebView(data);
    }
  }

  openWebView(Map<String, dynamic> data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewApp(
                  data: data,
                )));
  }

  @override
  void initState() {
    super.initState();
    generateTxnId();
    generateAmount();
  }

  // you don't need to create form, all the required things will come from api in production app

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            const Text(
              'MID',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: midController,
              decoration: const InputDecoration(
                hintText: 'Please enter the MID',
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between fields
            const Text(
              'API Key',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: apiKeyController,
              decoration: const InputDecoration(
                hintText: 'Please enter the API Key',
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between fields
            const Text(
              'Transaction ID',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: txnIdController,
              decoration: const InputDecoration(
                hintText: 'Please enter the transaction ID',
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between fields
            const Text(
              'Amount',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: amtController,
              decoration: InputDecoration(
                  hintText: '0.00',
                  errorText: _validate
                      ? 'Value has to be a number with two decimal places'
                      : null),
            ),
            const SizedBox(height: 32.0), // Add more spacing before the button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  updateValues();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
