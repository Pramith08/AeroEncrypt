import 'package:aeroencrypt/components/my_custom_home_page_transition.dart';
import 'package:aeroencrypt/pages/retrieve_pass_page.dart';
import 'package:aeroencrypt/pages/store_pass_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userId;
  // const HomePage({super.key, required this.userId});
  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;
// String lol = userId;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF07070A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select An Option",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      // fontFamily: "MontserratMedium",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Color(0xFFF4BBFF),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MyCustomHomePageRoute(
                              StorePassPage(
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.15,
                          alignment: Alignment.center,
                          child: Text(
                            "Store Password",
                            style: TextStyle(
                              color: Color(0xFF2D2A2E),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Material(
                      color: Color(0xFFF4BBFF),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MyCustomHomePageRoute(RetrievePassPage(
                            userId: widget.userId,
                          )));
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.15,
                          alignment: Alignment.center,
                          child: Text(
                            "Retrieve Password",
                            style: TextStyle(
                              color: Color(0xFF2D2A2E),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
