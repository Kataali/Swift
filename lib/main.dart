import 'package:flutter/material.dart';
import 'Views/welcomeScreen.dart';
import 'Views/loginScreen.dart';
import 'Views/registrationScreen.dart';
import 'Views/chatScreen.dart';

void main() => runApp(Swift());
class Swift extends StatelessWidget {
  const Swift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      initialRoute: 'welcome_screen',
      routes: {
        "welcome_screen": (context) => WelcomeScreen(),
        "login_screen": (context) => LoginScreen(),
        "registration_screen": (context) => RegistrationScreen(),
        "chat_screen": (context) => ChatScreen()
      },
    );
  }
}



