import 'package:flutter/material.dart';

class ButtonImage extends StatelessWidget {
  final double sizeImage;
  final String pathImage;
  final VoidCallback onPressed;

  const ButtonImage(
      {super.key,
      this.sizeImage = 20,
      this.pathImage = 'assets/imgs/google.png',
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFEEEEEE),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Image.asset(
        pathImage,
        width: sizeImage,
        height: sizeImage,
      ),
    );
  }
}
