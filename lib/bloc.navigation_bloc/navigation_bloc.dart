import 'package:bloc/bloc.dart';
import 'package:finaly/screens/bookingscreen.dart';
import 'package:finaly/screens/classroomlevels.dart';
import '../screens/myaccountspage.dart';
import '../screens/mybookings.dart';

import '../screens/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyBookingsClickedEvent,
  ClassroomClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  NavigationStates get initialState => const MyAccountsPage();


  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield const HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield const MyAccountsPage();
        break;
      case NavigationEvents.MyBookingsClickedEvent:
        yield const MyBookingsPage();
        break;
      case NavigationEvents.ClassroomClickedEvent:
        yield ClassroomPage();
        break;

    }
  }
}
