import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher/attendanceviewpage.dart';


class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

//for dropdown
String _selectAttendance = "Select";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        leading: Icon(Icons.arrow_back_sharp),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: StreamBuilder(
                    stream: Firestore.instance.collection('user').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Text('no value');
                      }else{
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            snapshot.data.documents.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(e['Name'] ?? 'N/A txt',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(e['Roll'] ?? 'N/A txt',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            elevation: 0,
                                            hint: Text(
                                              _selectAttendance,
                                            ),


                                            items: [

                                              DropdownMenuItem(
                                                
                                                child: Text("Absent"),
                                                value: "Absent",
                                              ),
                                              DropdownMenuItem(

                                                child: Text("Present"),
                                                value: "Present",
                                              ),

                                            ],
                                            onChanged: (_selectvalue) {
                                              setState(() {
                                                _selectAttendance = _selectvalue;
                                              });
                                            },
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                  Divider(height: 2,),

                                ],
                              );
                            }).toList()
                        );
                      }
                    }
                ),
              )
            ),

            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                    padding: EdgeInsets.all(12),
                    color: Colors.blue,

                    onPressed: (){

                    },
                    child: Text("Submit",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )
                )
            )
          ],
        ),
      )
    );
  }
}
