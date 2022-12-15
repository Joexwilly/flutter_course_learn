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
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joe Joe Application"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              // maxLines: 4,
              controller: _usernamecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                labelText: "Username",
                hintText: "Enter your name",
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          //password
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: _passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                labelText: "Password",
                hintText: "Enter your password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          //Elevated button
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                //show snackbar
                var username = _usernamecontroller.text;
                var password = _passwordcontroller.text;
                print("username: " + username + " password: " + password);
              },
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
