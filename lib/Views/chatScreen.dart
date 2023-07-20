import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
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
  final messageTextController = TextEditingController();

  // Functions
  // void messagesStream() async{
  //   await for(var messagesSnapshot in _firestore.collection("messages").snapshots()){
  //           for(var message in messagesSnapshot.docs){
  //
  //           }
  //   }
  // }

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
              icon: const Icon(Icons.power_settings_new_outlined),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Center(child: Text('Chat')),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              builder: (context, snapshot){
                List<MessageBubble> messageBubbles = [];
                if(!snapshot.hasData){
                  return BlurryModalProgressHUD(
                    child:Center(),
                    inAsyncCall: true,
                  );
                }
                  final messages = snapshot.data?.docs;
                  for(var message in messages!){
                          final messageText = message.data()['message'];
                          final sender = message.data()['sender'];
                          final messageBubble = MessageBubble(sender: sender, message: messageText);
                          messageBubbles.add(messageBubble);
                  }
                
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    children: messageBubbles,
                  ),
                );
              },
              stream: _firestore.collection("messages").snapshots(),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection("messages").add({
                        "message": message,
                        "sender": loggedInUser.email
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Text(
                              'Send',
                              style: mySendButtonTextStyle,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  const MessageBubble({super.key, required this.sender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender, style: TextStyle(fontSize: 12),),
          Material(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message, style: TextStyle(fontSize: 15, color: Colors.white),),
              ),),
        ],
      ),
    );
  }
}
