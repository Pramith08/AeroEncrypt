import 'package:flutter/material.dart';

void myCopySnackBar(
  BuildContext context,
  Color color,
  double _screenHeight,
  double _screenWidth,
  String _username,
  String _password,
) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
            color: const Color(0xFFF4BBFF),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: _screenWidth - 240,
                height: 50,
                alignment: Alignment.center,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: const Text(
                      "Copy Username",
                      style: TextStyle(
                        color: Color(0xFF2D2A2E),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: const Color(0xFFF4BBFF),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: _screenWidth - 240,
                height: 50,
                alignment: Alignment.center,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: const Text(
                      "Copy Password",
                      style: TextStyle(
                        color: Color(0xFF2D2A2E),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
