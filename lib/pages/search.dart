import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home_data/news_card_list.dart';
import 'single_blog.dart';

class JoeSearchPage extends StatefulWidget {
  const JoeSearchPage({super.key});

  @override
  State<JoeSearchPage> createState() => _JoeSearchPageState();
}

class _JoeSearchPageState extends State<JoeSearchPage> {
  //search controller
  final TextEditingController _searchController = TextEditingController();
  dynamic searchResult = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  //focusedborder
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  //focus color
                  focusColor: Colors.black,
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            //button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  //search
                  var searchText = _searchController.text;
                  //check if empty else search
                  if (searchText.length == 0) {
                    //show dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Search"),
                        content: const Text("Please enter a search term"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    //show snackbar for 1 minute
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Searching for $searchText"),
                        duration: const Duration(minutes: 1),
                      ),
                    );
                    //search
                    await searchPost(searchText);
                  }
                },
                child:
                    const Text("Search Post", style: TextStyle(fontSize: 15)),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            searchResult.length != 0
                ? Column(
                    children: [
                      for (var i = 0; i < searchResult.length; i++)
                        InkWell(
                          onTap: () {
                            //goto blog detail
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoeBlogDetail(
                                        blogdetail: searchResult[i])));
                          },
                          child: JoeBlogList().getCard(
                            thumbnail: searchResult[i]["image"],
                            title: searchResult[i]["title"],
                            description: searchResult[i]["content"],
                            author: searchResult[i]["author"],
                            date: searchResult[i]["date"],
                            comments: searchResult[i]["comments"]?.length,
                          ),
                        ),
                    ],
                  )
                : Column(
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  //make dio request
  searchPost(searchtext) async {
    var dio = Dio();
    var data = {"type": "posts", "search_text": searchtext};
    //convert to form
    var formData = new FormData.fromMap(data);

    //make request
    var response =
        await dio.post("https://xtrahola.com/api/search", data: formData);
    //hide snackbar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // check if response is 200
    if (response.data["code"] == 200) {
      // hide keyboard
      FocusScope.of(context).unfocus();

      //check if response is not empty

      //set state
      setState(() {
        searchResult = response.data["posts"];
      });
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Search Complete"),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      //show dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Search"),
          content: const Text("No result found"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(response.data["message"]),
            ),
          ],
        ),
      );
    }
  }
}
