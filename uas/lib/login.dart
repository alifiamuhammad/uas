import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uas/helper.dart';
import 'package:uas/register.dart';
import 'package:uas/widget.dart';
import 'package:uas/auth.dart';
import 'package:uas/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool loading = false;

  SignIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      await _authService.signInEmailAndPass(email, password).then((val) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
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
                      return val.isEmpty ? "Enter Emailid" : null;
                    },
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
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    validator: (val) {
                      return val.isEmpty ? "Enter password" : null;
                    },
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
                    height: 24,
                  ),
                  GestureDetector(
                      onTap: () {
                        SignIn();
                      },
                      child: blackButton(context: context, label: "Login")),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: TextStyle(fontSize: 15.5, color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
