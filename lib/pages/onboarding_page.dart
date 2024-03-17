import 'package:aeroencrypt/components/my_button.dart';
import 'package:aeroencrypt/components/my_custom_page_route.dart';
import 'package:aeroencrypt/components/onboard_column.dart';
import 'package:aeroencrypt/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;

bool _isLastPage = false;

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> setOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF07070A),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == 3) {
                        setState(() {
                          _isLastPage = true;
                        });
                      } else {
                        setState(() {
                          _isLastPage = false;
                        });
                      }
                    },
                    itemCount: OnBoardData.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnBoardColumn(
                      title: OnBoardData[index].title,
                      subTitle: OnBoardData[index].subTitle,
                      imagePath: OnBoardData[index].imagePath,
                      imageHeight: 250,
                      heightBetweenText: screenHeight * 0.01,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF4BBFF),
                              borderRadius: BorderRadius.circular(
                                15,
                              )),
                          child: MyButton(
                            height: 50,
                            width: 70,
                            buttonText: "Skip",
                            onTap: () {
                              _pageController.jumpToPage(3);
                            },
                          )),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: OnBoardData.length,
                        effect: SwapEffect(
                          activeDotColor: Color(0xFFF4BBFF),
                          dotColor: Colors.white,
                        ),
                      ),
                      _isLastPage
                          ? Container(
                              height: 50,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF4BBFF),
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  )),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MyCustomPageRoute(
                                      LoginPage(),
                                    ),
                                  );
                                  setOnboardingCompleted();
                                },
                                icon: Icon(
                                  color: Color(0xFF07070A),
                                  Icons.done_sharp,
                                ),
                              ),
                            )
                          : Container(
                              height: 50,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF4BBFF),
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  )),
                              child: IconButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                },
                                icon: Icon(
                                  color: Color(0xFF07070A),
                                  Icons.arrow_forward_ios_sharp,
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class OnBoard {
  final String title, subTitle, imagePath;

  OnBoard({
    required this.imagePath,
    required this.subTitle,
    required this.title,
  });
}

final List<OnBoard> OnBoardData = [
  OnBoard(
    title: "Ultimate Privacy for Your Digital Life",
    subTitle:
        "Begin your journey towards unmatched security. Store all your credentials securely, encrypted right on your device.",
    imagePath: "assets/images/introScreenPage1.png",
  ),
  OnBoard(
    title: "Always Encrypted, Always Yours",
    subTitle:
        "With end-to-end encryption, your data stays on your device. No cloud, no servers, just pure privacy.",
    imagePath: "assets/images/introScreenPage2.png",
  ),
  OnBoard(
    title: "Instantly Find What You Need",
    subTitle:
        "Organize and retrieve your credentials with ease using just the name of the app. A seamless experience across your devices.",
    imagePath: "assets/images/introScreenPage3.png",
  ),
  OnBoard(
    title: "Privacy That Stays With You",
    subTitle:
        "Your secrets are yours alone. Credentials stored on your device cannot be accessed elsewhere, ensuring your data's integrity and security.",
    imagePath: "assets/images/introScreenPage4.png",
  ),
];
