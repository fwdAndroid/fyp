import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaly/model/user_model.dart';

import 'package:finaly/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance
  .collection("users")
  .doc(user!.uid)
  .get()
  .then((value){
    this.loggedInUser = UserModel.fromMap(value.data());
    setState(() {
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Home Page",
        style:TextStyle(fontWeight: FontWeight.w900, fontSize: 28)),
      )
          );
  }

  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}

