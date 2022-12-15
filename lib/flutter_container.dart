import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() {
  //runapp
  runApp(const JoeEntryWidget());
}

//Entry wIDGET

class JoeEntryWidget extends StatelessWidget {
  const JoeEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //return materialApp
    return MaterialApp(
      title: "Joe Application",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: JoeHomePage(),
    );
  }
}

//JoeHomePage()

class JoeHomePage extends StatefulWidget {
  const JoeHomePage({super.key});

  @override
  State<JoeHomePage> createState() => _JoeHomePageState();
}

class _JoeHomePageState extends State<JoeHomePage> {
  //declare proterty indexcount

  //scaffoldkey
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joe Joe Application"),
      ),
      body: Container(
        height: 100,
        alignment: Alignment.bottomCenter,
        width: 350,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(3.0, 3.0),
              ),
            ]),
        child: Text(
          "I am Working here",
          style: TextStyle(fontSize: 20, color: Colors.yellow),
        ),
      ),
    );
  }
}
