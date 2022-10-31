import 'package:coco_meet/Utils/constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(emptyNotificationImg),
          const Text('Empty'),
          const Text("You don't have any notifications at this time"),
        ],
      ),
    );
  }
}
