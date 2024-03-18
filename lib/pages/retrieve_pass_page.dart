import 'package:aeroencrypt/components/my_app_list.dart';
import 'package:aeroencrypt/components/my_textfield.dart';
import 'package:aeroencrypt/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RetrievePassPage extends StatefulWidget {
  final String userId;

  const RetrievePassPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<RetrievePassPage> createState() => _RetrievePassPageState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;
TextEditingController _appNameController = TextEditingController();

class _RetrievePassPageState extends State<RetrievePassPage> {
  List<String> appNames = []; // Add this list to store app names
  List<String> displayedAppNames = [];

  @override
  void initState() {
    super.initState();
    _getAppNames();
  }

  void refreshAppNames() {
    _getAppNames();
  }

  void _getAppNames() async {
    String uId = widget.userId;
    List<String> retrievedAppNames = await getAppNames(uId);

    setState(() {
      appNames = retrievedAppNames;
      displayedAppNames =
          List<String>.from(appNames); // Initially, display all app names
    });
  }

  void _performSearch(String searchQuery) {
    setState(() {
      displayedAppNames = appNames
          .where((appName) =>
              appName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF07070A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Retrieve Password",
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //App Name Text Field
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextField(
                        onChange: (value) {
                          _performSearch(_appNameController.text);
                        },
                        controller: _appNameController,
                        hintText: "  App Name",
                        width: screenWidth * 0.75,
                        labelText: "Enter The App Name",
                      ),
                      Material(
                        color: const Color(0xFFF4BBFF),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          onTap: () {
                            _getAppNames();
                            _appNameController.clear();
                            //reset to display all the appname stored in the database
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: screenWidth * 0.12,
                            height: screenHeight * 0.06,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.restart_alt_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: displayedAppNames.length,
                  itemBuilder: (context, index) {
                    return MyAppList(
                      uId: widget.userId,
                      appName: displayedAppNames[index],
                      sHeight: screenHeight,
                      sWidth: screenWidth,
                      onDeletionComplete: refreshAppNames,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
