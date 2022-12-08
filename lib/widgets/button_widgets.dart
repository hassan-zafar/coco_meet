import 'package:coco_meet/Utils/constants.dart';
import 'package:flutter/material.dart';

OutlinedButton OutlinedIconButtons(IconData icon, onPressed) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      // backgroundColor: Colors.blue,
      fixedSize: const Size(80, 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Icon(icon),
  );
}

class BlueElevatedButton extends StatelessWidget {
  const BlueElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
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
        child: icon != null
            ? (Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(text),
                  const SizedBox(width: 10),
                  Icon(icon),
                ],
              ))
            : Text(text));
  }
}
