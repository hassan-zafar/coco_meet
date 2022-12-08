import 'package:coco_meet/Services/auth_service.dart';
import 'package:coco_meet/Utils/constants.dart';
import 'package:coco_meet/screens/profile_page_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(cocoMeetLogoIcon),
              const Text(
                'Create new Account',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade100)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade100)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      }),
                  const Text('Remember me'),
                ],
              ),
              BlueElevatedButton(text: 'Sign Up', onPressed: () {}),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('or Continue with',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedIconButtons(Icons.facebook, () {}),
                    OutlinedIconButtons(Icons.g_mobiledata, () {
                      AuthenticationService().signinWithGoogle().then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyProfilePageScreen())));
                    }),
                    OutlinedIconButtons(Icons.apple, () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
