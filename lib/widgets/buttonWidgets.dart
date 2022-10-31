import 'package:coco_meet/Utils/constants.dart';
import 'package:flutter/material.dart';

OutlinedButton outlinedIconButtons(IconData icon) {
  return OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      // backgroundColor: Colors.blue,
      fixedSize: const Size(80, 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
    ),
    child: Icon(icon, size: 32),
  );
}

class BlueElevatedButton extends StatelessWidget {
  BlueElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 10,
          fixedSize: const Size(400, 50),
          shadowColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(text));
  }
}
