import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;

class _ForgotPassPageState extends State<ForgotPassPage> {
  void back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF07070A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFF4BBFF),
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: IconButton(
                        onPressed: back,
                        icon: Icon(
                          color: Color(0xFF07070A),
                          Icons.arrow_back_ios_sharp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.04,
                    ),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        // fontFamily: "MontserratMedium",
                      ),
                    ),
                  ],
                ),
                Center(
                  // This will center the text horizontally
                  child: Text(
                    "You are not allowed to change the password!!",
                    textAlign: TextAlign
                        .center, // This will center the text if it wraps to a new line
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Adjust the font size as needed
                      fontFamily: "MontserratMedium",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
