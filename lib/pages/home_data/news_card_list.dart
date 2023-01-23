import 'package:flutter/material.dart';
//import flutter gestures
import 'package:flutter/gestures.dart';

//New class for Blog List Template
class JoeBlogList {
  //method
  Widget getCard({thumbnail, title, description, author, date, comments}) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          children: [
            //image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          height: 1.2),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //date and author

                    Text.rich(
                      TextSpan(
                        text: "by",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            height: 1.2,
                            fontWeight: FontWeight.normal),
                        children: [
                          TextSpan(
                            text: author,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                height: 1.2,
                                fontWeight: FontWeight.w900),
                          ),
                          TextSpan(
                            text: " at $date",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                height: 1.2,
                                fontWeight: FontWeight.normal),
                          ),
                          //comments
                          TextSpan(
                            text: " ($comments Comments)",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                height: 1.2,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.2,
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
