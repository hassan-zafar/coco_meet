import 'package:flutter/material.dart';

import '../../Utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cocoMeetLogoIcon),
              ),
              isThreeLine: true,
              title: const Text('Good Morning'),
              subtitle: const Text('Andrew Blabla'),
              trailing: const Icon(Icons.notifications_active),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Row(
              children: const [
                Text('Featured'),
                Text('See All'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
