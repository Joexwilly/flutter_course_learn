import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_naija/pages/cart/cart-function.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'cart.dart';

class JoeProductDetail extends StatefulWidget {
  const JoeProductDetail({super.key, this.product});
  final product;

  @override
  State<JoeProductDetail> createState() =>
      _JoeProductDetailState(product: product);
}

class _JoeProductDetailState extends State<JoeProductDetail> {
  var formatter = new NumberFormat("#,###,000");
  int quantity = 1;
  dynamic product;
  _JoeProductDetailState({this.product});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //add product to cart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product["image"],
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
            ),
            actions: [
              //go to cart
              IconButton(
                onPressed: () {
                  //go to cart JoeCartPage
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return JoeCartPage();
                  }));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
            //status bar color to white
            backgroundColor: Colors.black,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "₦${formatter.format(int.parse(product["price"]))}",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      //share icon
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          //share product
                          Share.share(
                              "Check out this product on Joe's Shop: ${product["title"]} at ${product["link"]}");
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    product["title"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      //add background color
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(product["category"])),
                  Text(
                    product["content"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //check if quantity is greater than 1
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // check if quantity is greater than 1

                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //add to cart container

                  InkWell(
                    onTap: () async {
                      JoeCartFunction()
                          .addToCart(product: product, quantity: quantity);
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Added to cart"),
                        duration: Duration(seconds: 2),
                      ));
                      //set state
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
