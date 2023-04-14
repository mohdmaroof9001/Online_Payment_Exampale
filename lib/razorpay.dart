// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayDemo extends StatefulWidget {
  const RazorPayDemo({Key? key}) : super(key: key);

  @override
  _RazorPayDemoState createState() => _RazorPayDemoState();
}

class _RazorPayDemoState extends State<RazorPayDemo> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    initRazorPay();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  initRazorPay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Sucessfull");
    print(
        "${response.orderId} \n${response.paymentId} \n${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
    print("${response.code} \n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Failed");
  }

  launchRazorPay() async {
    int amounts = int.parse(amount.text) * 100;
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$amounts",
      'name': name.text,
      'description': description.text,
      'prefill': {'contact': phone.text, 'email': email.text},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                textfieldDemo("Name", false, name),
                textfieldDemo("Phone No.", false, phone),
                textfieldDemo("Email", false, email),
                textfieldDemo("Description", false, description),
                textfieldDemo("Amount", true, amount),
                ElevatedButton(
                    onPressed: () {
                      launchRazorPay();
                    },
                    child: Text("Pay Now"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  textfieldDemo(
      String text, bool isNumerical, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 350,
        height: 50,
        child: TextField(
          controller: controller,
          keyboardType: isNumerical ? TextInputType.number : null,
          decoration:
              InputDecoration(hintText: text, border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
