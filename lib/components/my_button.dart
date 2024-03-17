import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final double height;
  final double width;
  final String buttonText;
  final VoidCallback onTap;

  const MyButton({
    super.key,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFF4BBFF),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Color(0xFF2D2A2E),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
