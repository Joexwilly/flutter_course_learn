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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("How are you"),
                Text("How are you"),
                Text("How are you"),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Text("This is Column")
          ],
        ),
      ),
    );
  }
}
