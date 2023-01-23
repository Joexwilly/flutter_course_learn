import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home.dart';

void main() {
  //runapp
  runApp(const JoeEntryWidget());
}

//Entry wIDGET

// class JoeEntryWidget extends StatelessWidget {
//   const JoeEntryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //return materialApp
//     return MaterialApp(
//       title: "Joe Application",
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: JoeHomePage(),
//     );
//   }
// }

// //JoeHomePage()

// class JoeHomePage extends StatefulWidget {
//   const JoeHomePage({super.key});

//   @override
//   State<JoeHomePage> createState() => _JoeHomePageState();
// }

// class _JoeHomePageState extends State<JoeHomePage> {
//   //declare proterty indexcount
//   int indexCount = 0;
//   //scaffoldkey
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       key: _scaffoldkey,
//       appBar: AppBar(
//         title: Text("Joe Application"),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: const [
//             UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   "https://images.unsplash.com/photo-1459802071246-377c0346da93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=818&q=80",
//                 ),
//                 backgroundColor: Colors.white,
//               ),
//               accountName: Text("Joe"),
//               accountEmail: Text("hello@vtuking.com"),
//             ),
//             ListTile(
//               title: Text("Home"),
//               leading: Icon(Icons.home),
//             ),
//             Divider(
//               color: Colors.black,
//               height: 0,
//             ),
//             ListTile(
//               title: Text("About"),
//               leading: Icon(Icons.info),
//             ),
//             Divider(
//               color: Colors.black,
//               height: 0,
//             ),
//             ListTile(
//               title: Text("Contact"),
//               leading: Icon(Icons.contact_phone),
//             ),
//             Divider(
//               color: Colors.black,
//               height: 0,
//             ),
//             ListTile(
//               title: Text("Settings"),
//               leading: Icon(Icons.settings),
//             ),
//             Divider(
//               color: Colors.black,
//               height: 0,
//             ),
//             ListTile(
//               title: Text("Logout"),
//               leading: Icon(Icons.exit_to_app),
//             ),
//             Divider(
//               color: Colors.black,
//             ),
//             ListTile(
//               title: Text("App Version: 1.0.0"),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print("I am working here");
//         },
//         child: Icon(Icons.share),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
//           child: Column(
//             children: [
//               Text(
//                 "I am Working here",
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//               ),
//               //image from network
//               Image.network(
//                 "https://images.unsplash.com/photo-1459802071246-377c0346da93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=818&q=80",
//                 width: 100.0,
//                 height: 100.0,
//                 alignment: Alignment.center,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                     "This is a sample text This is a sample text This is a sample text This is a sample text This is a sample text This is a sample text This is a sample text"),
//               ),
//               //add elevated button
//               ElevatedButton(
//                 onPressed: () {
//                   print("Button pressed");

//                   //show snackbar
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Button Pressed"),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 },
//                 child: Text("Click Me"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       persistentFooterButtons: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: Icon(Icons.home),
//               onPressed: () {
//                 print("Home Button Pressed");
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 print("Settings Button Pressed");
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.contact_phone),
//               onPressed: () {
//                 print("Contact Button Pressed");
//               },
//             ),
//           ],
//         ),
//       ],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: indexCount,
//         fixedColor: Colors.red,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Settings",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.contact_phone),
//             label: "Contact",
//           ),
//         ],
//         onTap: (int index) {
//           print("Index $index");

//           //update indexCount state
//           setState(
//             () {
//               indexCount = index;
//             },
//           );
//         },
//       ),
//     );
//   }
// }
