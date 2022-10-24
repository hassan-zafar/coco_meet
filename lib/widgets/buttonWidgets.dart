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
  const BlueElevatedButton({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF584cf4),
          fixedSize: const Size(400, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {},
        child: Text(text));
  }
}
