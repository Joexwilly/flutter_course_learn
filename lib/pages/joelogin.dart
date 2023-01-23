// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoeLoginPage extends StatefulWidget {
  const JoeLoginPage({super.key});

  @override
  State<JoeLoginPage> createState() => _JoeLoginPageState();
}

class _JoeLoginPageState extends State<JoeLoginPage> {
  //email controller
  final emailController = TextEditingController();
  //password controller
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Comment"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Login to Comment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //user email input
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  //border color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: "Email",
                  hintText: "Enter Email",
                ),
              ),
            ),
            //user password input
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  //border color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: "Password",
                  hintText: "Enter Password",
                ),
              ),
            ),
            //login button
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  //get email value
                  var email = emailController.text;
                  //get password value
                  var password = passwordController.text;
                  //check email and password is empty
                  if (email.length == 0 || password.length == 0) {
                    //show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Email and Password cannot be empty"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    //process login
                    processLogin(email, password).then((value) => {
                          //show success message
                          if (value)
                            {
                              //close page
                              Navigator.pop(context)
                            }

                          //show success message
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text("Login Success"),
                          //   ),
                          // );
                        });
                  }
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // process login
  processLogin(email, password) async {
    //dio post request
    var dio = Dio();
    //post data
    var data = {"email": email, "password": password};
    //use form data to send data
    var formData = FormData.fromMap(data);
    //post request
    var response =
        await dio.post("https://xtrahola.com/api/user_login", data: formData);
    //check if response is successful

    if (response.data["code"] == 200) {
      //shared preferences
      //save user dara
      final prefs = await SharedPreferences.getInstance();
      //encode userdata
      var userData = response.data;
      //encode useer data
      var encodedata = jsonEncode(userData);
      //save userdata
      prefs.setString("userdetail", encodedata);

      //show success messagem,_s(irec[ee])
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Login Successful"),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      return true;
    } else {
      //show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data["error"]),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
