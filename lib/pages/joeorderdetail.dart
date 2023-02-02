import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoeOrderDetail extends StatefulWidget {
  final order;
  const JoeOrderDetail({super.key, this.order});

  @override
  State<JoeOrderDetail> createState() => _JoeOrderDetailState(this.order);
}

class _JoeOrderDetailState extends State<JoeOrderDetail> {
  final order;
  dynamic products = [];
  _JoeOrderDetailState(this.order);
  var formatter = new NumberFormat("#,###,000");

  @override
  void initState() {
    super.initState();
  }

//get order detail
  getOrderDetail() async {
    var dio = Dio();
    var user = await userData();

    var response = await dio.get(
      "https://xtrahola.com/order-api-single/get_order_by_id/${user["id"]}/${order["order_id"]}",
    );
    //set state
    setState(() {
      products = response.data["products"];
    });
  }

  //userdata
  userData() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      //get string
      var userdetail = prefs.getString('userdetail');
      //decode userdetail
      var userdetaildecoded = jsonDecode(userdetail!);
      return userdetaildecoded;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Detail"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text("Ordered Products:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          products.length > 0
              ? Column(
                  children: [
                    for (var product in products)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 8),
                        child: Card(
                          child: ListTile(
                            leading: Image(
                              image: NetworkImage(product["product"]["image"]),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product["product"]["title"]),
                            subtitle: Text(
                                "Qty: ${product["quantity"]} * ${product["product"]["price"]}"),
                            trailing: Text(
                              "₦${formatter.format(int.parse(product["product"]["price"]) * int.parse(product["quantity"]))}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Order Status: ${order["status"]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Order Date: ${order["date"]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("No Products ordered"),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Go to Home"))
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
