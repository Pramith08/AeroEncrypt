import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final String labelText;
  final Function(String) onChange;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.width,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      child: TextField(
        onChanged: onChange,
        cursorColor: const Color(0xFF213277),
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF212121),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF474747),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          labelText: labelText,
          hintStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Color(0xFF666B70),
              fontSize: 15,
            ),
          ),
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Color(0xFF666B70),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
