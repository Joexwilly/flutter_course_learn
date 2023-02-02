// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_naija/pages/cart/cart-function.dart';
import 'package:flutter_naija/pages/checkout.dart';
import 'package:intl/intl.dart';

// cart page

class JoeCartPage extends StatefulWidget {
  const JoeCartPage({super.key});

  @override
  State<JoeCartPage> createState() => _JoeCartPageState();
}

class _JoeCartPageState extends State<JoeCartPage> {
  dynamic cart = [];
  JoeCartFunction joeCartFunction = JoeCartFunction();
  var formatter = new NumberFormat("#,###,000");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  //get cart
  getCart() async {
    //get cart from shared preferences
    // var prefs = await SharedPreferences.getInstance();
    // var cart = prefs.getString("cart");
    // if (cart != null) {
    //   setState(() {

    var cartRes = await joeCartFunction.getCart();
    //update state
    setState(() {
      cart = cartRes;
    });
    //   });
    // }
  }

  //getTotal
  getTotal() {
    int total = 0;
    for (var i = 0; i < cart.length; i++) {
      int price = int.parse(cart[i]["product"]["price"]);
      int quantity = cart[i]["quantity"];
      total += price * quantity;
    }
    return total;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: cart.length > 0
            ? Column(
                children: [
                  for (var i = 0; i < cart.length; i++)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //product image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        cart[i]["product"]["image"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              //product name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    reduceWords(cart[i]["product"]["title"]),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  //product price
                                  Text(
                                    "₦${formatter.format(int.parse(cart[i]["product"]["price"]))}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  //product quantity
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              //check if quantity is greater than 1
                                              if (cart[i]["quantity"] > 1) {
                                                //decrement quantity
                                                var newQuantity =
                                                    cart[i]["quantity"] - 1;
                                                //update cart
                                                joeCartFunction.addToCart(
                                                    product: cart[i]["product"],
                                                    quantity: newQuantity);
                                                //update state
                                                getCart();
                                              }
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                            cart[i]["quantity"].toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //increment quantity
                                              var newQuantity =
                                                  cart[i]["quantity"] + 1;
                                              //update cart
                                              joeCartFunction.addToCart(
                                                  product: cart[i]["product"],
                                                  quantity: newQuantity);
                                              //update state
                                              getCart();
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                        width: 10,
                                      ),
                                      //remove cart icon
                                      InkWell(
                                        onTap: () {
                                          //remove cart
                                          joeCartFunction.removeFromCart(
                                              productid: cart[i]["product_id"]);
                                          //show snackbar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Item removed from cart")));
                                          //update state
                                          getCart();
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        "₦${formatter.format((int.parse(cart[i]["product"]["price"]) * cart[i]["quantity"]))}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  //footer
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "₦${formatter.format(getTotal())}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //checkout button
                  InkWell(
                    onTap: () {
                      //check if cart is empty
                      if (cart.length > 0) {
                        //navigate to checkout page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JoeCheckout(
                              totalAmount: getTotal(),
                            ),
                          ),
                        );
                      } else {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Cart is empty, add items to cart")));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      //center aligned
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        //radius
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Your cart is empty",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          //close cart
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          //backgroun color
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            "Go to Shop",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  //reduce words more than 25
  String reduceWords(String text) {
    if (text.length > 25) {
      return text.substring(0, 20) + "...";
    } else {
      return text;
    }
  }
}
