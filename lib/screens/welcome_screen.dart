import 'package:coco_meet/Utils/constants.dart';
import 'package:coco_meet/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(welcomeFrame),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Let's You In",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            iconTextOutlinedBtn(
                context: context,
                icon: const Icon(Icons.facebook),
                text: 'Continue with Facebook'),
            iconTextOutlinedBtn(
                context: context,
                icon: const Icon(Icons.g_mobiledata_outlined),
                text: 'Continue with Google'),
            iconTextOutlinedBtn(
                context: context,
                icon: const Icon(Icons.apple),
                text: 'Continue with Apple'),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('or'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BlueElevatedButton(
                  text: 'Sign Up with Password',
                  onPressed: () {
                    // Navigator.pushNamed(context, '/signup');
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Center iconTextOutlinedBtn({context, String? text, Icon? icon}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
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
