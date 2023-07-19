import 'package:flutter/material.dart';
import 'Views/welcomeScreen.dart';
import 'Views/loginScreen.dart';
import 'Views/registrationScreen.dart';
import 'Views/chatScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Swift());
}
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



