import 'package:finaly/screens/login_screen.dart';
import 'package:finaly/screens/registration_screen.dart';
import 'package:finaly/sidebar/sidebar.dart';
import 'package:finaly/sidebar/sidebar_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }

}


