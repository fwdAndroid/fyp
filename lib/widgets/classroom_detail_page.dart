import 'package:finaly/model/classroom_model.dart';
import 'package:flutter/material.dart';

class Classroomdetails extends StatefulWidget {
  final Classroom_model classroom;

  const Classroomdetails({Key? key, required this.classroom}) : super(key: key);

  @override
  _ClassroomdetailsState createState() => _ClassroomdetailsState();
}

class _ClassroomdetailsState extends State<Classroomdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _detAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _classroomSection(),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Classroom ' +
                      widget.classroom.className,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
  AppBar _detAppBar() {
    return AppBar(
      backgroundColor: Color(0xffd70826),
      elevation: 0,
    );
  }
  Container _classroomSection(){
    return Container(
      height: 250,
      color: const Color(0xffd70826),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 250,
              child: Image(
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitHeight,
                image: (AssetImage('assets/' + widget.classroom.image)),

                ),
            ),
          )
        ],
      ),
    );
  }
}
