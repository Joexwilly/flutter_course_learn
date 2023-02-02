import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class JoeCartFunction {
  //add to cart
  addToCart({product, quantity}) async {
    //shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get cart
    var cart = prefs.getString("cart");
    //check if cart is null
    if (cart == null) {
      //create new cart
      var newCart = [];
      //add product to cart
      newCart.add({
        "product": product,
        "quantity": quantity,
        "product_id": product["product_id"],
      });
      //save cart
      prefs.setString("cart", jsonEncode(newCart));
    } else {
      //cart is not null
      //decode cart
      var decodedCart = jsonDecode(cart);
      //check if product is already in cart
      var index = decodedCart
          .indexWhere((element) => element["product"]["id"] == product["id"]);
      //check if index is -1
      if (index == -1) {
        //add product to cart
        decodedCart.add({
          "product": product,
          "quantity": quantity,
          "product_id": product["product_id"],
        });
        //save cart
        prefs.setString("cart", jsonEncode(decodedCart));
      } else {
        //update quantity
        decodedCart[index]["quantity"] = quantity;
        //save cart
        prefs.setString("cart", jsonEncode(decodedCart));
      }
    }
  }

  //get cart
  getCart() async {
    //shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get cart
    var cart = prefs.getString("cart");
    //check if cart is null
    if (cart == null) {
      return [];
    } else {
      //cart is not null
      //decode cart
      var decodedCart = jsonDecode(cart);
      return decodedCart;
    }
  }

  //remove from cart
  removeFromCart({productid}) async {
    //shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get cart
    var cart = prefs.getString("cart");
    //check if cart is null
    if (cart == null) {
      return [];
    } else {
      //cart is not null
      //decode cart
      var decodedCart = jsonDecode(cart);
      //remove product from cart
      decodedCart.removeWhere((element) => element["product_id"] == productid);
      //save cart
      prefs.setString("cart", jsonEncode(decodedCart));
    }
  }

  //clear cart
  clearCart() async {
    //shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //empty cart
    prefs.setString("cart", jsonEncode([]));
  }
}
