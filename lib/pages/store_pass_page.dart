import 'package:aeroencrypt/components/my_button.dart';
import 'package:aeroencrypt/components/my_textfield.dart';
import 'package:aeroencrypt/components/my_pass_textfield.dart';
import 'package:aeroencrypt/components/my_snack_bar.dart';
import 'package:aeroencrypt/components/my_title_text.dart';
import 'package:aeroencrypt/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StorePassPage extends StatefulWidget {
  final String userId;
  const StorePassPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<StorePassPage> createState() => _StorePassPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;

TextEditingController _appNameController = TextEditingController();
TextEditingController _userNameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _StorePassPageState extends State<StorePassPage> {
  void _storeData() async {
    FocusScope.of(context).unfocus();

    //Write function here
    String appName = _appNameController.text.toLowerCase().trim();
    String username = _userNameController.text.trim();
    String password = _passwordController.text.trim();

    // Call the addData function here
    try {
      if (_appNameController.text.isEmpty &&
          _userNameController.text.isEmpty &&
          _passwordController.text.isEmpty) {
        mySnackBar(context, "Fill Your Details", Colors.red);
        return;
      }
      if (_appNameController.text.isEmpty) {
        mySnackBar(context, "Fill Your App Name", Colors.red);
        return;
      }
      if (_userNameController.text.isEmpty) {
        mySnackBar(context, "Fill Your Username", Colors.red);
        return;
      }
      if (_passwordController.text.isEmpty) {
        mySnackBar(context, "Fill Your Password", Colors.red);
        return;
      }
      try {
        await addData(widget.userId, appName, username, password);
        mySnackBar(context, "Successfully Stored", Colors.green);
        Navigator.pop(context);
      } on Exception catch (e) {
        mySnackBar(context, e.toString(), Colors.red);
      }
    } on Exception catch (e) {
      mySnackBar(context, e.toString(), Colors.red);
    }

    _appNameController.clear();
    _userNameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF07070A),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyTitleText(
                      title: "Store Password",
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "App Name",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFC3BBBB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                MyTextField(
                  onChange: (value) {},
                  controller: _appNameController,
                  hintText: "  App Name",
                  width: screenWidth - 45,
                  labelText: "Enter Your App Name",
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),

                //Username Text Field
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "Username",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFC3BBBB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                MyTextField(
                  onChange: (value) {},
                  controller: _userNameController,
                  hintText: "  Username",
                  width: screenWidth - 45,
                  labelText: "Enter Your Username",
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),

                //Password Text Field
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFC3BBBB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                MyPasswordTextField(
                  controller: _passwordController,
                  hintText: "  Password",
                  labelText: "Enter Your Password",
                  width: screenWidth - 45,
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                // Expanded(
                //   child: SizedBox(),
                // ),
                MyButton(
                  height: 55,
                  width: screenWidth - 55,
                  buttonText: "Store Password",
                  onTap: () async {
                    _storeData();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
