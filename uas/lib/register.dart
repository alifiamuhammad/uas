import 'package:flutter/material.dart';
import 'package:uas/auth.dart';
import 'package:uas/login.dart';
import 'package:uas/adada.dart';
import 'package:flutter/services.dart';
import 'package:uas/home.dart';
import 'package:uas/splas.dart';
import 'package:uas/widget.dart';

import 'helper.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email, password, name;

  SignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      await authService.signUpWithEmailAndPassword(email, password).then((val) {
        if (val != null) {
          setState(() {
            loading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: appBar(context),
        elevation: 1.10,
        backgroundColor: Colors.white,
      ),
      body: loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  Spacer(),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    validator: (val) {
                      return val.isEmpty ? "Entr your name" : null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    validator: validateEmail,
                    decoration: InputDecoration(
                      hintText: "email",
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: validatePassword,
                    decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      SignUp();
                    },
                    child: Container(
                        child:
                            blackButton(context: context, label: "Register")),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " have an account?",
                        style: TextStyle(fontSize: 15.5),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            " Sign In",
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value == "") {
    return "Email is Required";
  } else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePassword(String value) {
  Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "Password is Required";
  } else if (!regex.hasMatch(value))
    return 'Password required: Alphabet, Number & 8 chars';
  else
    return null;
}
