import 'package:flutter/material.dart';
//create ecommerce page

class JoeEcommerce extends StatefulWidget {
  const JoeEcommerce({super.key});

  @override
  State<JoeEcommerce> createState() => _JoeEcommerceState();
}

class _JoeEcommerceState extends State<JoeEcommerce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is Ecommerce"),
    );
  }
}
