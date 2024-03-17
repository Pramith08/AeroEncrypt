import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitleText extends StatelessWidget {
  final String title;
  const MyTitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 35,
        ),
      ),
    );
  }
}
