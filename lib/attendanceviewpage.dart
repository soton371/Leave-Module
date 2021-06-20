import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Viewattendance extends StatefulWidget {

  bool rcheck_select;

  @override
  _ViewattendanceState createState() => _ViewattendanceState();
}

class _ViewattendanceState extends State<Viewattendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance View"),
        leading: Icon(Icons.arrow_back_sharp),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      offset: Offset(1, 1),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1, -1),
                      blurRadius: 5,
                    )
                  ]),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Demo",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),),
                      Text("0320503116")
                    ],
                  ),
                  Spacer(),
                  widget.rcheck_select==true?Text("Present",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green
                    ),):Text("Absent",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red
                    ),)
                ],
              ),
            ),

          ],
        ),
      ),
    );;
  }
}
