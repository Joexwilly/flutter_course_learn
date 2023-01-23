import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoeBlogComment extends StatefulWidget {
  final commentArray;
  final postId;
  const JoeBlogComment({this.commentArray, this.postId});

  @override
  State<JoeBlogComment> createState() =>
      // ignore: no_logic_in_create_state
      _JoeBlogCommentState(commentArray: commentArray, postId: postId);
}

class _JoeBlogCommentState extends State<JoeBlogComment> {
  dynamic commentArray;
  dynamic postId;
  _JoeBlogCommentState({this.commentArray, this.postId});

//formkey
  final formKey = GlobalKey<FormState>();
//commentcontroller
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment"),
      ),
      body: Container(
        child: CommentBox(
          // userImage: CommentBox.commentImageParser(
          //     imageURLorPath: "assets/img/userpic.jpg"),
          child: commentChild(commentArray),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: true,
          sendButtonMethod: () async {
            //get data from shared preferences
            final prefs = await SharedPreferences.getInstance();
            //get string
            var userdetail = prefs.getString('userdetail');
            //decode userdetail
            var userdetaildecoded = jsonDecode(userdetail!);
            print(userdetaildecoded["userDetails"]);
            if (formKey.currentState!.validate()) {
              // print(commentController.text);
              //send comment to server
              submitComment(userdetaildecoded["userDetails"]["id"],
                  commentController.text, postId);
            } else {
              // print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  //comment child
  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  // print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 30,
                    ),
                  ),
                ),
              ),
              title: Text(
                data[i]['user'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['comment']),
              trailing:
                  Text(data[i]['date'], style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  //submit comment
  submitComment(user_id, message, post_id) async {
    //use dio
    var dio = Dio();
    //send data to server
    var data = {
      "user_id": user_id,
      "message": message,
      "post_id": post_id,
    };
    //convert to formdata
    var formData = FormData.fromMap(data);

    //send data to server
    var response =
        await dio.post("https://xtrahola.com/api/add_comment", data: formData);
    if (response.data["code"] == 200) {
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("comment added, awaiting admin approval"),
        backgroundColor: Colors.green,
      ));

      //send data to server
      commentController.clear();
      FocusScope.of(context).unfocus();
    } else {
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unable to add comment"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
