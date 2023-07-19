import 'package:flutter/material.dart';
import 'chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Variables
  final _auth = FirebaseAuth.instance;
  String username = "";
  String email = "";
  String password = "";
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.blue,
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset("images/pot_logo_1.jpg"),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // TextField(
                //   textAlign: TextAlign.center,
                //   onChanged: (value) {
                //     username = value;
                //   },
                //   decoration: InputDecoration(
                //     hintText: "Enter your Username",
                //     border: OutlineInputBorder(
                //         //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //         ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blueAccent),
                //       borderRadius: BorderRadius.circular(32.0),
                //       //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blueAccent),
                //       borderRadius: BorderRadius.circular(32.0),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(32.0),
                      //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(32.0),
                      //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try{
                        UserCredential newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newUser != null){
                          Navigator.pushNamed(context, 'chat_screen');
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                      catch (e){
                        print(e);
                      }
                      },
                    child: Text("Signup", style: TextStyle(fontSize: 20),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
