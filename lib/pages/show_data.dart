import 'package:aeroencrypt/components/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:aeroencrypt/services/database.dart';

class ShowData extends StatefulWidget {
  final List<Map<String, String?>> allAppData;
  final String uId;
  final String appName;
  final Function onDeletionComplete;

  ShowData({
    required this.allAppData,
    required this.appName,
    required this.uId,
    required this.onDeletionComplete,
  });

  @override
  _ShowDataState createState() => _ShowDataState();
}

double screenWidth = 0.0;
double screenHeight = 0.0;

class _ShowDataState extends State<ShowData> {
  Future<void> _showMyDialog(String uniqueId, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF4BBFF),
          title: const Text(
            'Alert',
            style: TextStyle(
              color: Color(0xFF2D2A2E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "MontserratMedium",
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Would you like to delete this credential?',
                  style: TextStyle(
                    color: Color(0xFF2D2A2E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "MontserratMedium",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D2A2E),
                  fontWeight: FontWeight.w700,
                  fontFamily: "MontserratMedium",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "MontserratMedium",
                ),
              ),
              onPressed: () async {
                await deleteCredential(uniqueId, widget.uId, widget.appName);
                setState(() {
                  widget.allAppData.removeAt(index);
                });

                Navigator.of(context).pop();
                widget.onDeletionComplete();
              },
            ),
            SizedBox(
              width: screenWidth * 0.001,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF07070A),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF4BBFF),
          title: Center(
            child: Text(
              widget.appName,
              style: TextStyle(
                color: Color(0xFF2D2A2E),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                // fontFamily: "MontserratMedium",
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.allAppData.length,
          itemBuilder: (context, index) {
            final credential = widget.allAppData[index];
            final username = credential['username'] ?? 'N/A';
            final password = credential['password'] ?? 'N/A';
            final uniqueId = credential['uniqueId'];
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              _showMyDialog(uniqueId!, index);
                            },
                            child: Container(
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Color(0xFF2D2A2E),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "MontserratMedium",
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              width: (screenWidth - 20) / 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    child: MyListTile(
                      password: password,
                      userName: username,
                      sHeight: screenHeight,
                      sWidth: screenWidth,
                    ),
                  )
                ],
              );
            } else {
              return Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          _showMyDialog(uniqueId!, index);
                        },
                        child: Container(
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Color(0xFF2D2A2E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "MontserratMedium",
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          width: (screenWidth - 20) / 2,
                        ),
                      ),
                    )
                  ],
                ),
                child: MyListTile(
                  password: password,
                  userName: username,
                  sHeight: screenHeight,
                  sWidth: screenWidth,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
