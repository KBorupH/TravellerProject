import 'package:flutter/material.dart';

class WebToastNotificationWidget extends StatelessWidget {
  const WebToastNotificationWidget({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          //icon
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.train),
          ),
          Column(children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
            Text(body),
          ],)

          //msg
        ]),
      ),
    );
  }
}

