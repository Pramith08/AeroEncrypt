// import 'package:aeroencrypt/components/my_copy_data_snack_bar.dart';
import 'package:aeroencrypt/components/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final String userName;
  final String password;
  final double sHeight;
  final double sWidth;
  const MyListTile(
      {super.key,
      required this.password,
      required this.userName,
      required this.sHeight,
      required this.sWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF4BBFF),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: password));
            mySnackBar(
                context, "Password for '$userName' copied", Colors.green);
          },
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username: ',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Color(0xFF474747),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '$userName',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Color(0xFF131313),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy,
                  color: Color(0xFF2D2A2E),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
