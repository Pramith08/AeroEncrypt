import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final String labelText;

  MyPasswordTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.width,
  });

  @override
  _MyPasswordTextFieldState createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: widget.width,
      child: TextField(
        cursorColor: const Color(0xFF213277),
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        controller: widget.controller,
        obscureText: _isObscure,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF111214),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF3E3F43),
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
          labelText: widget.labelText,
          // hintText: widget.hintText,
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
          suffixIcon: IconButton(
            color: Color(0xFF666B70),
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
