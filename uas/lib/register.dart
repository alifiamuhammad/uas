import 'package:flutter/material.dart';
import 'package:uas/auth.dart';
import 'package:uas/login.dart';
import 'package:flutter/services.dart';
import 'package:uas/home.dart';
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
              context, MaterialPageRoute(builder: (context) => Home()));
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
        backgroundColor: Colors.transparent,
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
                    validator: validateEmail,
                    decoration: InputDecoration(hintText: "email"),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: validatePassword,
                    decoration: InputDecoration(hintText: "password"),
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      SignUp();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width - 48,
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
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
