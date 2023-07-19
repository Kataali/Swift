import 'package:flutter/material.dart';
import 'package:swift/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatScreen extends StatefulWidget {
    const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Variables
  String message = "";
  final FirebaseAuth _auth = FirebaseAuth.instance; //
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;

  // Functions
  void messagesStream() async{
    await for(var messagesSnapshot in _firestore.collection("messages").snapshots()){
            for(var message in messagesSnapshot.docs){

            }
    }
  }

  @override
  void initState() {
    super.initState();
    // call function to get the info of user
    getCurrentUser();
  }


  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if(user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                // StreamBuilder(
                //   builder: (context, snapshot){
                //     if(snapshot.hasData){
                //       final messages = snapshot.data;
                //     }
                //   },
                //   stream: _firestore.collection("messages").snapshots(),
                // ),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            message = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _firestore.collection("messages").add({
                            "message": message,
                            "sender": loggedInUser.email
                          });
                        },
                        child: Icon(Icons.arrow_forward_ios_rounded),
                        // child: Text(
                        //   'Send',
                        //   style: kSendButtonTextStyle,
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
