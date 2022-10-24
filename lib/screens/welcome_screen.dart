import 'package:coco_meet/utils/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(welcomeFrame),
          IconTextOutlinedBtn(
              context: context,
              icon: const Icon(Icons.facebook),
              text: 'Continue with Facebook'),
          IconTextOutlinedBtn(
              context: context,
              icon: const Icon(Icons.g_mobiledata_outlined),
              text: 'Continue with Google'),
          IconTextOutlinedBtn(
              context: context,
              icon: const Icon(Icons.apple),
              text: 'Continue with Apple'),
        ],
      ),
    );
  }

  Center IconTextOutlinedBtn({context, String? text, Icon? icon}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon!,
                Text(text!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
