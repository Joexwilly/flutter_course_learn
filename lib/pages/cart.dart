import 'package:flutter/material.dart';

// cart page

class JoeCartPage extends StatefulWidget {
  const JoeCartPage({super.key});

  @override
  State<JoeCartPage> createState() => _JoeCartPageState();
}

class _JoeCartPageState extends State<JoeCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Container(
        child: Text("I am Cart Page"),
      ),
    );
  }
}
