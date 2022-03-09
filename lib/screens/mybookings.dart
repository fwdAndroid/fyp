import 'package:finaly/model/classroom_model.dart';
import 'package:finaly/widgets/classroom_detail_page.dart';
import 'package:finaly/widgets/hd_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:finaly/screens/bookingscreen.dart';
import 'homepage.dart';

class MyBookingsPage extends StatefulWidget with NavigationStates {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage>
    with SingleTickerProviderStateMixin<MyBookingsPage> {
  List<Classroom_model> _classroom = <Classroom_model>[];

  _onCellTap(Classroom_model classroom) {
    Navigator.push(context, MaterialPageRoute(builder: (context)
    =>
        Classroomdetails(classroom: classroom)
    ));
  }

  @override
  void initState() {
    super.initState();
    _classroom = _getClassroom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(

          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xffd70826),
                    image: DecorationImage(
                        image: AssetImage("assets/redvacc.jpg")),
                  )),
            ),
            const Text("Type of Classrooms",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28)),
            SizedBox(height: 25),
            Column(
              children: [
                _classroomSection(),
              ],
            ),


            SizedBox(height: 25),
            SizedBox(height: 8),
            SizedBox(height: 48),
            SizedBox(height: 20),
          ],

        ),


      ),


    );
  }

  SizedBox _classroomSection() {
    return SizedBox(
      height: 199,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _classroom.length,

        separatorBuilder: (BuildContext context, int index) =>
        const Divider(indent: 12),
        itemBuilder: (BuildContext context, int index) =>
            HDCell(
              classroom: _classroom[index],
              onTap: () => _onCellTap(_classroom[index]),
              key: null,),

      ),
    );
  }


  List<Classroom_model> _getClassroom() {
    List<Classroom_model> _classroom = <Classroom_model>[];

    _classroom.add(Classroom_model(
        className: 'S505', image: 'class1.jpg', type: 'Not vaccinated'));
    _classroom.add(Classroom_model(
        className: 'S509', image: 'class2.jpg', type: 'One dose'));
    _classroom.add(Classroom_model(
        className: 'S507', image: 'class3.jpg', type: 'Fully Vaccinated'));
    return _classroom;
  }


}
