import 'package:aeroencrypt/pages/show_data.dart';
import 'package:aeroencrypt/services/database.dart';
import 'package:flutter/material.dart';

class MyAppList extends StatefulWidget {
  final String appName;
  final String uId;
  final double sHeight;
  final double sWidth;
  final Function onDeletionComplete;

  const MyAppList({
    super.key,
    required this.appName,
    required this.sHeight,
    required this.uId,
    required this.sWidth,
    required this.onDeletionComplete,
  });

  @override
  State<MyAppList> createState() => _MyAppListState();
}

class _MyAppListState extends State<MyAppList> {
  @override
  Widget build(BuildContext context) {
    void _retrieveAndDisplayData(
        BuildContext context, String appName, uId) async {
      List<Map<String, String?>> allAppData = await getData(uId, appName);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowData(
            allAppData: allAppData,
            appName: widget.appName,
            uId: uId,
            onDeletionComplete: widget.onDeletionComplete,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF4BBFF),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            _retrieveAndDisplayData(
              context,
              widget.appName,
              widget.uId,
            );
          },
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Name: ',
                  style: TextStyle(
                    color: Color(0xFF474747),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "MontserratMedium",
                  ),
                ),
                Text(
                  widget.appName,
                  style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "MontserratMedium",
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
