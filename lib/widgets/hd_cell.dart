import 'package:finaly/model/classroom_model.dart';
import 'package:flutter/material.dart';

class HDCell extends StatelessWidget {
  final Classroom_model classroom;
  final Function onTap;

  const HDCell({Key? key, required this.classroom, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          width: 285,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xffd70826),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 32,
                left: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Classroom ' + classroom.className,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    Text('Type for ' + classroom.type,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    const Text('Students',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 77,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(32)),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  )),
              Positioned(
                  right: 0,
                  top: 50,
                  bottom: 0,
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: Hero(
                      tag: "x",
                      child: Image(

                        filterQuality: FilterQuality.high,
                        image: AssetImage('assets/' + classroom.image),

                      ),


                    ),
                  ))
            ],
          )),
    );
  }
}
