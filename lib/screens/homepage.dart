import 'dart:convert';
import 'dart:developer';

import 'package:finaly/widgets/constant.dart';
import 'package:finaly/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../bloc.navigation_bloc/navigation_bloc.dart';

class HomePage extends StatefulWidget with NavigationStates {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  Map? worldData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xffd70826),
                    image: DecorationImage(
                        image: AssetImage("assets/logostaffs.jpg")),
                  )),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest updates",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (worldData == null) const CircularProgressIndicator() else Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: roundNumber(worldData?['active']),
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: roundNumber(worldData?['deaths']),
                          title: "Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: roundNumber(worldData?['todayRecovered']),
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String roundNumber(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)}K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)}K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)}M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)}B";
    } else {
      return num.toString();
    }
  }

  fetchWorldWideData() async {
    String url = 'https://disease.sh/v3/covid-19/all';
    http.Response response = await http.get(Uri.parse(url));
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

