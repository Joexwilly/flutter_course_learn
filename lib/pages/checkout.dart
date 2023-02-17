// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:ade_flutterwave_working_version/core/ade_flutterwave.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_naija/pages/cart/cart-function.dart';
import 'package:flutter_theoaks_paystack/flutter_theoaks_paystack.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/joelogin.dart';
import 'joeorderpage.dart';

class JoeCheckout extends StatefulWidget {
  final totalAmount;
  const JoeCheckout({super.key, this.totalAmount});

  @override
  State<JoeCheckout> createState() =>
      _JoeCheckoutState(totalAmount: totalAmount);
}

class _JoeCheckoutState extends State<JoeCheckout> {
  var formatter = new NumberFormat("#,###,000");
  dynamic totalAmount;
  _JoeCheckoutState({this.totalAmount});
  final plugin = PaystackPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    plugin.initialize(
        publicKey: "pk_test_c3e1a97b37a782f5967da897c9e8ef7068fba62a");
  }

//check if user is logged in
  isUserloggedIn() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    var user_detail = prefs.getString("userdetail");
    if (user_detail == null) {
      return false;
    } else {
      
      return true;
    }
  }

  getTotal() async {
    int total = 0;
    var cart = await JoeCartFunction().getCart();
    for (var i = 0; i < cart.length; i++) {
      int price = int.parse(cart[i]["product"]["price"]);
      int quantity = cart[i]["quantity"];
      total += price * quantity;
    }
    return total;
  }

  //process flutterwave
  processFlutterwave() async {
    //get data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    //get string
    var userdetail = prefs.getString('userdetail');
    //decode userdetail
    var userdetaildecoded = jsonDecode(userdetail!);
    var user_id = userdetaildecoded["user_details"]["id"];
    print(userdetaildecoded["userDetails"]);
    print(userdetaildecoded["user_details"]);

    //data
    var data = {
      'amount': totalAmount,
      'email': "${userdetaildecoded["user_details"]["email"]}",
      'phone': "",
      'name': "${userdetaildecoded["user_details"]["name"]}",
      'title': 'Products Flutterwave payment',
      'currency': "NGN",
      'tx_ref': "AdeFlutterwave-${DateTime.now().millisecondsSinceEpoch}",
      'icon': "https://www.aqskill.com/wp-content/uploads/2020/05/logo-pde.png",
      'public_key': "FLWPUBK_TEST-7cd2262e0df0fbd43aca42e2d5f478d9-X",
      'sk_key': 'FLWSECK_TEST-ca148479377714e836526cc61c8c633a-X'
    };

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdeFlutterWavePay(data),
      ),
    ).then((payresponse) async {
      //response is the response from the payment
      if (payresponse["status"] != "success") {
        //show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Payment failed"),
          backgroundColor: Colors.red,
        ));
        return false;
      }

      var tx_id = payresponse["data"]["tx_id"];
      processServerData(tx_id, "flutterwave", user_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Column(
        children: [
          Container(
            //total amount
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "₦${formatter.format(totalAmount)}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
              ],
            ),
          ),
          //Divider
          Divider(
            thickness: 2,
          ),
          //payment method title
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //icon
                Icon(
                  Icons.credit_card,
                  size: 30,
                )
              ],
            ),
          ),
          //flutterwave
          InkWell(
            onTap: () async {
              isUserloggedIn().then((value) {
                if (value) {
                  //process flutterwave payment

                  processFlutterwave();
                } else {
                  //goto login page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JoeLoginPage()));
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                //add background color
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                width: double.infinity,
                child: Image(
                    image: NetworkImage(
                        "https://www.electronicpaymentsinternational.com/wp-content/uploads/sites/4/2020/01/Flutterwave.png"),
                    height: 60,
                    width: double.infinity),
              ),
            ),
          ),
          //paystack
          InkWell(
            onTap: () async {
              isUserloggedIn().then((value) {
                if (value) {
                  //process paystack payment
                  processPaystack(context);
                } else {
                  //goto login page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JoeLoginPage()));
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                //add background color
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                width: double.infinity,
                child: Image(
                    image: NetworkImage(
                        "https://uploads-ssl.webflow.com/5edfc79600691067acf835bd/6079706c752a09007a6ebea3_Paystack_Logo.png"),
                    height: 60,
                    width: double.infinity),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //process serverData
  processServerData(tx_id, gateway, user_id) async {
    //get cart
    var allcart = await JoeCartFunction().getCart();
    var products = [];
    for (var cartdata in allcart) {
      products.add({
        "product_id": cartdata["product_id"],
        "quantity": cartdata["quantity"],
        "product_price": cartdata["product"]["price"],
      });
    }
    var dio = Dio();
    var total = await getTotal();
    //send data to server
    var serverData = {
      "user_id": user_id,
      "products": products,
      "total": total,
      "payment_gateway": gateway,
      "trx_id": "$tx_id",
    };

    //send data to server

    //convert to formdata
    var formData = FormData.fromMap(serverData);

    //send data to server
    var response =
        await dio.post("https://xtrahola.com/api/create_order", data: formData);
    //check if the response is 200
    if (response.data["code"] == 200) {
      //clear cart
      await JoeCartFunction().clearCart();
      //go to order page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => JoeOrderPage(),
        ),
      );
    } else {
      //show info
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.data["message"]),
      ));
    }
  }

  //paystack
  processPaystack(context) async {
    //get data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    //get string
    var userdetail = prefs.getString('userdetail');
    //decode userdetail
    var userdetaildecoded = jsonDecode(userdetail!);
    var total = await getTotal();
    Charge charge = Charge()
      ..amount = total * 100
      ..reference = "ecommerceapp-${DateTime.now().millisecondsSinceEpoch}"
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = "${userdetaildecoded["user_details"]["email"]}";
    CheckoutResponse response = await plugin.checkout(
      context = context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    // var tx_id = response.reference;
    // var user_id = userdetaildecoded["user_details"]["id"];
    if (response.status) {
      processServerData(response.reference, "paystack",
          userdetaildecoded["user_details"]["id"]);
    } else {
      //show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Payment failed"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
