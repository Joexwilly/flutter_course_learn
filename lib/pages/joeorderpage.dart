import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';
import 'joeorderdetail.dart';

class JoeOrderPage extends StatefulWidget {
  const JoeOrderPage({super.key});

  @override
  State<JoeOrderPage> createState() => _JoeOrderPageState();
}

class _JoeOrderPageState extends State<JoeOrderPage> {
  dynamic orders = [];
  //get orders
  getOrders() async {
    var dio = Dio();
    var user = await userData();
    if (user != null) {
      var response = await dio.get(
        "https://xtrahola.com/order-api/get_order/${user["id"]}",
      );
      //set state
      setState(() {
        orders = response.data;
      });
    }
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
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Order Page"),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return JoeHomePage();
              }));
            },
          )),
      body: SingleChildScrollView(
        child: orders.length > 0
            ? Column(
                children: [
                  for (var order in orders)
                    InkWell(
                      onTap: () {
                        //go to order details
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JoeOrderDetail(order: order);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 5),
                            child: ListTile(
                              title: Text(
                                "${order["order_id"]}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Order Date: ${order["date"]}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Order Status: ${order["status"]}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                "N${order["amount"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("No Order Yet"),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          //go to order details
                          getOrders();
                        },
                        child: const Text(
                          "Refresh",
                          style: TextStyle(color: Colors.red),
                        ))
                  ])),
      ),
    );
  }
}
