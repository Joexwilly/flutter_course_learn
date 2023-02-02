import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'pages/home_data/news_card.dart';

import 'pages/cart.dart';

import 'pages/joeorderpage.dart';
import 'pages/search.dart';
import 'pages/shop.dart';

//Entry wIDGET

class JoeEntryWidget extends StatelessWidget {
  const JoeEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //return materialApp
    return MaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
        primary: Colors.white,
        onPrimary: Colors.black,
      )),
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
  int pageIndex = 0;
  late String apptitle = "News App";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          apptitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('My News App');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              //navigate to search page 'JoeSearchPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JoeSearchPage(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: pageIndex == 0 ? Colors.white : Colors.red,
        foregroundColor: pageIndex == 0 ? Colors.black : Colors.white,
      ),
      body: IndexedStack(
        index: pageIndex,
        children: [
          JoeBlogPage(),
          JoeEcommerce(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          switch (index) {
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JoeCartPage()));

              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JoeOrderPage()));
              break;
            default:
              setState(() {
                pageIndex = index;
                if (index == 0) {
                  apptitle = "News App";
                } else {
                  apptitle = "Ecommerce";
                }
              });
          }
        },
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.black),
            label: "Ecommerce",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            label: "Order",
          ),
        ],
      ),
    );
  }
}
