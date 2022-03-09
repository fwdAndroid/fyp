import 'package:finaly/model/user_model.dart';
import 'package:finaly/sidebar/sidebar_layout.dart';
import 'package:finaly/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {



  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final vacStatusEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  List<String> vacinationStatus = ["Not vaccinated", "One dose", "Fully vaccinated"];
  var selectionVac;





  @override
  Widget build(BuildContext context) {


    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value){
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty){
            return ("Firstname cannot be empty");
          }
          if (!regex.hasMatch(value))
          {
            return("Please Enter valid Password (Min of 6 characters");
          }
        },
        onSaved:(value)
        {
          firstNameEditingController.text = value!;

        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        //validator
        onSaved:(value)
        {
          secondNameEditingController.text = value!;


        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Surname",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value){
          if (value!.isEmpty){
            return ("Please Enter your Email");
          }
          // reexpression for email validation
          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
          {
            return ("Please Enter your Email");
          }
          return null;
        },
        onSaved:(value)
        {
          emailEditingController.text = value!;

        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final vacStatusField = DropdownButtonFormField<String>(
        iconSize: 0,
        autofocus: false,
        value:selectionVac,
        onChanged:(newValue){
            setState((){
              selectionVac=newValue;
            });
          },
          items:vacinationStatus.map((valueItem){
            return DropdownMenuItem(
              value:valueItem,
              child:Text(valueItem),
            );
          }).toList(),

        decoration:InputDecoration(
          prefixIcon:Icon(Icons.arrow_drop_down),
          contentPadding:EdgeInsets.fromLTRB(20,15,20,15),
          hintText:"Select Vaccination Status:",
          border:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value){
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty){
            return ("Password is required for register");
          }
          if (!regex.hasMatch(value))
          {
            return("Please Enter valid Password (Min of 6 characters");
          }
        },
        onSaved:(value)
        {
          passwordEditingController.text = value!;

        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value)
        {
          if(confirmPasswordEditingController.text != passwordEditingController.text)
            {
              return "Password don't match";
            }
          return null;
        },
        onSaved:(value)
        {
          confirmPasswordEditingController.text = value!;

        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final signupButton = Material(
      elevation: 5,
      color: Color(0xffd70826),
      borderRadius:BorderRadius.circular(30),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: (){
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: const Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color:  Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xffd70826)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
        ),
        body: Center(

          child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children:<Widget>[

                              SizedBox(
                                  height: 150,
                                  child: Image.asset("assets/logostaffs.jpg",
                                    fit:BoxFit.contain,
                                  )),
                              SizedBox(height: 25),
                              firstNameField,
                              SizedBox(height: 25),
                              secondNameField,
                              SizedBox(height: 25),
                              emailField,
                              SizedBox(height: 25),
                              vacStatusField,
                              SizedBox(height: 25),
                              passwordField,
                              SizedBox(height: 25),
                              confirmPasswordField,
                              SizedBox(height: 25),
                              signupButton,
                              SizedBox(height: 25),


                            ]
                        )
                    ),
                  )
              )
          ),
        )
    );
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
      postDetailsToFirestore()

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }



  postDetailsToFirestore() async
  {
    //calling firstore
    //calling user model
    // sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //including all the values
    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.vacStatus = selectionVac;
    userModel.admin = false;

    await firebaseFirestore
    .collection ("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => SideBarLayout()),
    (route) => false);
  }

}
