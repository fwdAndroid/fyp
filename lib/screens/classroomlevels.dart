import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class ClassroomPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Classromgfdag",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}