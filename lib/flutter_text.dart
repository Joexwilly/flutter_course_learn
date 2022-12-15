import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            height: 100,
            child: Text(
              "Welcome to VTUking yes i am the auther and the creator you are the bose and the stadia",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  wordSpacing: 3),
            ),
          ),
          RichText(
            text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.app_registration),
                  ),
                  TextSpan(
                    text: " Sign Up ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Sign Up");
                      },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
