import 'package:finaly/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(const HomePage()),
        child: Stack(
          children: [
            BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, navigationStates) {
                  return navigationStates as Widget;
                }),
            const SideBar(),
          ],
        ),
      ),
    );
  }
}
