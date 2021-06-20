import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher/leaveapplication.dart';
import 'package:teacher/leaveapplicationview.dart';

class LeaveRequestView extends StatefulWidget {

  @override
  _LeaveRequestViewState createState() => _LeaveRequestViewState();
}

class _LeaveRequestViewState extends State<LeaveRequestView> {

  //bool apply;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 60, 30, 50),
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Row(
                      children: <Widget>[
                        BackButton(
                          color: Colors.white70,
                        ),
                        Expanded(
                            child: Text(
                          'Request  View',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: FlatButton.icon(
                              label: Text('Log Out',
                                  style: TextStyle(
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.bold)),
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.cyan,
                                size: 15,
                              ),
                              onPressed: () async {}),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 130, 40, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(51, 204, 255, 0.3),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.5),
                      child: Text(
                        "Student Name",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    Firestore.instance.collection("leaverequest").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading");
                  }
                  var _leaverequestdata = snapshot.data.documents;
                  List<Widget> leaverequestviewWidgets = [];
                  for (var i in _leaverequestdata){
                    final leaverequestviewWidget = Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              )],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Apply Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan),
                                        ),
                                        Text(i.data["currentdate"]),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "From",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan),
                                        ),
                                        Text(i.data["from"]),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "To",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan),
                                        ),
                                        Text(i.data["to"]),
                                      ],
                                    ),
                                  ],
                                ),
                                //end apply date section
                                SizedBox(height: 20,),
                                //start issue section
                                Row(
                                  children: [
                                    Text("Issue: ",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),),
                                    Text(i.data["issue"],style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                  ],
                                ),
                                //end issue section
                                SizedBox(height: 10,),
                                //start explain section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Description: ",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Divider(height: 2,),
                                    Text(i.data["explain"],textAlign: TextAlign.justify,)
                                  ],
                                )
                                //end explain section
                              ],
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    );
                    leaverequestviewWidgets.add(leaverequestviewWidget);
                  }
                  return Column(
                    children: leaverequestviewWidgets
                  );
                }),
            //for button section
            Container(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      onPressed: (){

                        String apply = "Accept";
                        Firestore.instance.collection("approve").add({
                          "select": apply
                        });

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplicationView()));
                      },
                      child: Text("Accept",style: TextStyle(color: Colors.white)),
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  FlatButton(
                    onPressed: (){
                      String apply = "Reject";
                      Firestore.instance.collection("approve").add({
                        "select": apply
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplicationView()));
                    },
                    child: Text("Reject",style: TextStyle(color: Colors.white),),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
