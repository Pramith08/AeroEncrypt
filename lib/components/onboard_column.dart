import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardColumn extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  final double imageHeight;
  final double heightBetweenText;

  const OnBoardColumn({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.imageHeight,
    required this.heightBetweenText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          imagePath,
          height: 250,
        ),
        Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: heightBetweenText,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
