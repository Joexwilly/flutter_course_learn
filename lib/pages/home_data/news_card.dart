import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../single_blog.dart';
import 'news_card_list.dart';

//create blog stateful widget
class JoeBlogPage extends StatefulWidget {
  const JoeBlogPage({super.key});

  @override
  State<JoeBlogPage> createState() => _JoeBlogPageState();
}

class _JoeBlogPageState extends State<JoeBlogPage> {
  dynamic blogheader = null;
  dynamic blogbody = null;
  //on init
  @override
  void initState() {
    super.initState();
    //get data
    getBlog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //blog header
            blogheader != null
                ? InkWell(
                    onTap: (() {
                      //goto blog detail
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JoeBlogDetail(blogdetail: blogheader)));
                    }),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      //background Image
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(blogheader["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.black.withOpacity(.0),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              blogheader["title"],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800),
                            )),
                      ),
                    ),
                  )
                : const Center(
                    child: Padding(
                    padding: EdgeInsets.all(60.0),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )),
            //body
            blogbody != null
                ? Column(
                    children: [
                      for (var i = 0; i < blogbody.length; i++)
                        InkWell(
                          onTap: () {
                            //goto blog detail
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoeBlogDetail(
                                        blogdetail: blogbody[i])));
                          },
                          child: JoeBlogList().getCard(
                            thumbnail: blogbody[i]["image"],
                            title: blogbody[i]["title"],
                            description: blogbody[i]["content"],
                            author: blogbody[i]["author"],
                            date: blogbody[i]["date"],
                            comments: blogbody[i]["comments"]?.length,
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(60.0),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  //get_posts

  void getBlog() async {
    try {
      var response = await Dio().get('https://xtrahola.com/api/get_posts');
      var data = response.data;
      var firstindex = data[0];
      var body = data.sublist(1);
      print(data[0]["title"]);
      setState(() {
        blogheader = firstindex;
        blogbody = body;
      });
    } catch (e) {
      print(e);
    }
  }
}
