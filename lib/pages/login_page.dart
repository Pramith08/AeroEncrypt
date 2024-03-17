// import 'dart:html';

import 'package:aeroencrypt/components/my_button.dart';
import 'package:aeroencrypt/components/my_custom_home_page_transition.dart';
import 'package:aeroencrypt/components/my_custom_page_route.dart';
import 'package:aeroencrypt/components/my_textfield.dart';
import 'package:aeroencrypt/components/my_pass_textfield.dart';
import 'package:aeroencrypt/components/my_snack_bar.dart';
import 'package:aeroencrypt/components/my_title_text.dart';
import 'package:aeroencrypt/pages/forgot_pass_page.dart';
import 'package:aeroencrypt/pages/home_page.dart';
import 'package:aeroencrypt/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;
TextEditingController _loginEmailController = TextEditingController();
TextEditingController _loginPassController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPassController.dispose();
    super.dispose();
  }

  void newUser() {
    Navigator.push(
      context,
      MyCustomHomePageRoute(
        RegisterPage(),
      ),
    );
  }

  void forgotPassword() {
    Navigator.push(
      context,
      MyCustomHomePageRoute(
        ForgotPassPage(),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFC3BBBB),
        ),
      ),
    );
    try {
      if (_loginEmailController.text.isEmpty &&
          _loginPassController.text.isEmpty) {
        mySnackBar(context, "Enter Your Email and Password", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_loginEmailController.text.isEmpty) {
        mySnackBar(context, "Enter Your Email", Colors.red);
        Navigator.pop(context);
        return;
      }
      if (_loginPassController.text.isEmpty) {
        mySnackBar(context, "Enter Your Password", Colors.red);
        Navigator.pop(context);
        return;
      }
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text,
        password: _loginPassController.text,
      );

      Navigator.pop(context);
      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        Navigator.of(context).pushReplacement(
          MyCustomPageRoute(
            HomePage(
              userId: userId,
            ),
          ),
        );
        _loginEmailController.clear();
        _loginPassController.clear();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mySnackBar(context, "User Not Found", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'wrong-password') {
        mySnackBar(context, "Wrong Password", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'invalid-email') {
        mySnackBar(context, "Invalid Credentials", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'invalid-credential') {
        mySnackBar(context, "Wrong Password", Colors.red);
        Navigator.pop(context);
        return;
      } else if (e.code == 'network-request-failed') {
        mySnackBar(context, "Check Your Network Connection", Colors.red);
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
    return SafeArea(
      child: Scaffold(
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
                  MyTitleText(
                    title: "Sign In",
                  ),
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
                controller: _loginEmailController,
                hintText: "  Email",
                width: screenWidth - 45,
                labelText: "Enter Your Email",
              ),
              SizedBox(
                height: screenHeight * 0.01,
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
                controller: _loginPassController,
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
                width: screenWidth - 45,
                buttonText: "Login",
                onTap: () {
                  FocusScope.of(context).unfocus();
                  login(context);

                  _loginEmailController.clear();
                  _loginPassController.clear();
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(240, 40),
                    ),
                    onPressed: newUser,
                    child: Text(
                      "Not a user..?  Create new user!",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Color(0xFFC3BBBB),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
