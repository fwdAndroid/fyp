

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finaly/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:finaly/widgets/button_widget.dart';
import 'package:finaly/widgets/firebase_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'homepage.dart';



class MyAccountsPage extends StatefulWidget with NavigationStates {
  const MyAccountsPage({Key? key}) : super(key: key);

  @override
  _MyAccountsPageState createState() => _MyAccountsPageState();
}


  class _MyAccountsPageState extends State<MyAccountsPage> with SingleTickerProviderStateMixin<MyAccountsPage>{
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

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
                        image: AssetImage("assets/redvacc.jpg")),
                  )),
            ),
              const Text("Verification of COVID status",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28)),
              SizedBox(height: 25),
              const Text("Please provide picture of your COVID passport",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
                ),
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonWidget(
                  text: 'Upload File',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: uploadFile,
                ),
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),


    );}

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;



    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();


  }

  Widget buildUploadStatus(UploadTask task) =>
      StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}






