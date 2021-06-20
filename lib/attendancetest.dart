import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceTest extends StatefulWidget {
  @override
  _AttendanceTestState createState() => _AttendanceTestState();
}

class _AttendanceTestState extends State<AttendanceTest> {
//for dropdown
  String _selectAttendance = "Select";


  //for get data from firebase
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null){
        loggedInUser = user;
      }
    } catch (e){
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection("user").getDocuments();
  //   for (var message in messages.documents){
  //     print(message.data);
  //   }
  // }

  void messagesStream()async{
    await for (var snapshot in _firestore.collection('user').snapshots()){
      for (var message in snapshot.documents){
        print(message.data);
      }
    }
  }

  //for attendance button
  bool _attendance = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AttendanceTest"),
          leading: Icon(Icons.arrow_back_sharp),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("user").snapshots(),
                builder: (context, snapshot){
                  if (!snapshot.hasData){
                    return Text("loading");
                  }
                    final messages = snapshot.data.documents;
                    //List<Text> messageWidgets = [];
                  List<Widget> messageWidgets = [];
                    for (var message in messages){
                      final messageText = message.data['Name'];
                      final messageSender = message.data['Roll'];
                      final messageWidget = Text('$messageText from $messageSender');
                      messageWidgets.add(messageWidget);
                    }
                    return GestureDetector(
                      child: Column(
                        children: messageWidgets,
                      ),
                    );
                }
            ),
            Container(
              child: FlatButton(
                color: Colors.blue,
        onPressed: (){},
                  child: Text("Submit")),
            )
          ],
        )
    );
  }
}

