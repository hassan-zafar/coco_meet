import 'package:coco_meet/Utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/buttonWidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool rememberMe = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            BlueElevatedButton(text: 'Sign Up', onPressed: null),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Forgot the password',
                  style: TextStyle(
                      color: Color(0xFF584cf4),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('or Continue with',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  outlinedIconButtons(Icons.facebook),
                  outlinedIconButtons(Icons.g_mobiledata),
                  outlinedIconButtons(Icons.apple),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
