// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GPay extends StatefulWidget {
  const GPay({Key? key}) : super(key: key);

  @override
  _GPayState createState() => _GPayState();
}

class _GPayState extends State<GPay> {
  TextEditingController amounts = TextEditingController();
  final _paymentItems = <PaymentItem>[
    // PaymentItem(
    //   label: 'Total',
    //   amount: '$amount',
    //   status: PaymentItemStatus.final_price,
    // )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    _paymentItems.add(PaymentItem(
        amount: amounts.toString(),
        label: 'Total',
        status: PaymentItemStatus.final_price));
    return Scaffold(
      appBar: AppBar(
        title: Text('G-Pay'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 350,
            height: 50,
            child: TextField(
              controller: amounts,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Amounts", border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GooglePayButton(
            width: 200,
            height: 80,
            paymentConfigurationAsset: 'images/gpay.json',
            paymentItems: _paymentItems,
            style: GooglePayButtonStyle.black,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      )),
    );
  }
}
