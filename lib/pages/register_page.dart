import 'package:aeroencrypt/components/my_custom_page_route.dart';
import 'package:aeroencrypt/components/my_textfield.dart';
import 'package:aeroencrypt/components/my_pass_textfield.dart';
import 'package:aeroencrypt/components/my_snack_bar.dart';
import 'package:aeroencrypt/components/my_title_text.dart';
import 'package:aeroencrypt/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _registerEmailController;
  late TextEditingController _registerPassController;
  // late TextEditingController _registerNameController;
  late TextEditingController _confirmRegisterPassController;

  @override
  void initState() {
    super.initState();
    _registerEmailController = TextEditingController();
    // _registerNameController = TextEditingController();
    _registerPassController = TextEditingController();
    _confirmRegisterPassController = TextEditingController();
  }

  @override
  void dispose() {
    _registerEmailController.dispose();
    // _registerNameController.dispose();
    _registerPassController.dispose();
    _confirmRegisterPassController.dispose();
    super.dispose();
  }

  void back() {
    Navigator.pop(context);
  }

  Future<void> createNewUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFC3BBBB),
        ),
      ),
    );
    try {
      if (_registerEmailController.text.isEmpty &&
          _registerPassController.text.isEmpty &&
          _confirmRegisterPassController.text.isEmpty) {
        mySnackBar(context, "Fill Your Details", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_registerEmailController.text.isEmpty &&
          _registerPassController.text.isEmpty) {
        mySnackBar(context, "Enter Your Email and Password", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_confirmRegisterPassController.text.isEmpty) {
        mySnackBar(context, "Enter Your Password Again", Colors.red);
        Navigator.pop(context);
        return;
      }

      if (_registerEmailController.text.isEmpty) {
        mySnackBar(context, "Enter Your Email", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_registerPassController.text.isEmpty) {
        mySnackBar(context, "Enter Your Password", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_registerPassController.text != _confirmRegisterPassController.text) {
        mySnackBar(context, "Your Password Doesn't Match", Colors.red);
        _confirmRegisterPassController.clear();
        Navigator.pop(context);
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _registerEmailController.text,
              password: _registerPassController.text);
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MyCustomPageRoute(LoginPage()),
        );
        _registerEmailController.clear();
        _registerPassController.clear();
        _confirmRegisterPassController.clear();
        // _registerNameController.clear();
      }

      Navigator.pop(context);
      back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        mySnackBar(context, "Invalid Email", Colors.red);
        _registerEmailController.clear();
        _registerPassController.clear();
        _confirmRegisterPassController.clear();
        Navigator.pop(context);
        return;
      } else if (e.code == 'invalid-credential') {
        mySnackBar(context, "Invalid Credential", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'network-request-failed') {
        mySnackBar(context, "Check Your Network Connection", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'weak-password') {
        mySnackBar(context, "Please Enter A Strong Password", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'email-already-in-use') {
        mySnackBar(context, "UserID Already Exist", Colors.red);
        Navigator.pop(context);
        return;
      }

      mySnackBar(context, e.toString(), Colors.red);
      Navigator.pop(context);
    } catch (e) {
      mySnackBar(context, e.toString(), Colors.red);
      Navigator.pop(context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF07070A),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //       color: Color(0xFFF4BBFF),
                //       borderRadius: BorderRadius.circular(
                //         15,
                //       )),
                //   child: IconButton(
                //     onPressed: back,
                //     icon: Icon(
                //       color: Color(0xFF07070A),
                //       Icons.arrow_back_ios_sharp,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: screenWidth * 0.04,
                // ),
                MyTitleText(
                  title: "Sign Up",
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Text(
                    "Email",
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
            SizedBox(
              height: 3,
            ),
            MyTextField(
              onChange: (value) {},
              controller: _registerEmailController,
              hintText: "  Email",
              width: screenWidth - 45,
              labelText: "Enter Your Email",
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
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
            SizedBox(
              height: 3,
            ),
            MyPasswordTextField(
                controller: _registerPassController,
                hintText: "  Password",
                labelText: "Enter Your Password",
                width: screenWidth - 45),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Text(
                    "Confirm Password",
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
            SizedBox(
              height: 3,
            ),
            MyPasswordTextField(
              controller: _confirmRegisterPassController,
              hintText: "  Password",
              labelText: "Confirm Your Password",
              width: screenWidth - 45,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            // Expanded(
            //   child: SizedBox(),
            // ),
            Material(
              color: Color(0xFFF4BBFF),
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  createNewUser(context);
                  // _registerEmailController.clear();
                  // _registerPassController.clear();
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: screenWidth - 45,
                  height: 55,
                  alignment: Alignment.center,
                  child: Text(
                    "Register",
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
            ),
          ],
        ),
      ),
    );
  }
}
