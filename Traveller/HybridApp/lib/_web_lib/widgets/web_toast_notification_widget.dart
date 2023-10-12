import 'package:flutter/material.dart';

class WebToastNotificationWidget extends StatelessWidget {
  const WebToastNotificationWidget(
      {super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        // color: const Color(0xff266aa6),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //icon
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(Icons.train, color: Colors.white, size: 40,),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                  body,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
