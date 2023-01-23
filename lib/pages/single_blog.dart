import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naija/pages/joelogin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment.dart';

//JoeBlogDetail

class JoeBlogDetail extends StatefulWidget {
  final blogdetail;
  const JoeBlogDetail({Key? key, this.blogdetail}) : super(key: key);

  @override
  State<JoeBlogDetail> createState() =>
      // ignore: no_logic_in_create_state
      _JoeBlogDetailState(blogdetail: blogdetail);
}

class _JoeBlogDetailState extends State<JoeBlogDetail> {
  final blogdetail;
  // ignore: avoid_init_to_null
  dynamic blogcontent = null;
  dynamic blogcomment = null;
  //consstructor
  _JoeBlogDetailState({this.blogdetail});

  //oninit
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBlogContent();
    getBlogComment();
  }

  //check if user is logged in
  isUserLoggedIn() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    var userDetail = prefs.getString('userdetail');

    if (userDetail == null) {
      return false;
    } else {
      return true;
    }
  }

  //getBlogContent
  getBlogContent() async {
    try {
      var response = await Dio()
          // ignore: prefer_interpolation_to_compose_strings
          .get('https://xtrahola.com/api/get_post/${blogdetail["post_id"]}');
      var data = response.data;
      setState(() {
        blogcontent = data["content"];
      });
    } catch (e) {
      print(e);
    }
  }

  //getBlogComment
  getBlogComment() async {
    try {
      var response = await Dio()
          // ignore: prefer_interpolation_to_compose_strings
          .get(
              'https://xtrahola.com/api/get_comments/${blogdetail["post_id"]}');
      var data = response.data;
      // print(data);
      setState(() {
        blogcomment = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogdetail["title"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              //background Image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(blogdetail["image"]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.black.withOpacity(.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      blogdetail["title"],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          height: 1.2,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          blogdetail["author"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          blogdetail["date"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //share icon and comment
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Share.share(
                          '${blogdetail["title"]} - ${blogdetail["link"]}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.comment,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          isUserLoggedIn().then((value) {
                            if (value) {
                              //goto comment page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoeBlogComment(
                                            commentArray: blogcomment,
                                            postId: blogdetail["post_id"],
                                          )));
                            } else {
                              //goto login page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoeLoginPage()));
                            }
                          });
                        },
                        child: Text(
                          "(${blogcomment != null ? blogcomment.length : '--'}) Comments",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Divider

            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            //content
            Container(
              padding: const EdgeInsets.all(15),
              child: blogcontent != null
                  ? Text(
                      blogcontent,
                      maxLines: 100,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.normal),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    ),
            ),
            //recent comments
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Comments",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            height: 1.2,
                            fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      //icon to add comment
                      Icon(
                        Icons.add_comment,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      InkWell(
                        onTap: (() {
                          //goto comment page
                          isUserLoggedIn().then((value) {
                            if (value) {
                              //goto comment page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoeBlogComment(
                                          commentArray: blogcomment,
                                          postId: blogdetail["post_id"])));
                            } else {
                              //goto login page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoeLoginPage()));
                            }
                          });
                        }),
                        child: Text(
                          "Add Comment",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  blogcomment != null
                      ? Column(
                          children: [
                            blogcomment.length > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              blogcomment[0]["user"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              blogcomment[0]["comment"],
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Column(
                                      children: [
                                        const Divider(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: const Text(
                                                  "No comments yet",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: const Text(
                                                  "Be the first to comment",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(50.0),
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          ),
                        ),

                  //load more comments
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: (() {
                      //goto comment page
                      isUserLoggedIn().then((value) {
                        if (value) {
                          //goto comment page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoeBlogComment(
                                      commentArray: blogcomment,
                                      postId: blogdetail["post_id"])));
                        } else {
                          //goto login page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoeLoginPage()));
                        }
                      });
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Load More Comments",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              height: 1.2,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
