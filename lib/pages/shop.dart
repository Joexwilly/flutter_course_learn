import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../pages/home_data/product-data.dart';

import '../pages/home_data/slider.dart';
//create ecommerce page

class JoeEcommerce extends StatefulWidget {
  const JoeEcommerce({super.key});

  @override
  State<JoeEcommerce> createState() => _JoeEcommerceState();
}

class _JoeEcommerceState extends State<JoeEcommerce> {
  dynamic products = [];
  dynamic productsHeader = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  //get products
  getProducts() async {
    var dio = Dio();
    var response = await dio.get("https://xtrahola.com/api/get_product");
    //pick two products from productsHeader
    var productsHeader1 = response.data.sublist(0, 2);
    //pick the rest of the products and take out the first two
    var products1 = response.data.sublist(2);
    setState(() {
      products = products1;
      productsHeader = productsHeader1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: products.length > 0
            ? Column(
                children: [
                  JoeProductSlider().getProductSlider(
                      height: height, products: productsHeader),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  // product list
                  JoeProductCard().getCard(context, products)
                ],
              )
            : Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
      ),
    );
  }
}
