import 'package:flutter/material.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class BookingScreen extends StatelessWidget with NavigationStates {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Accounts",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
