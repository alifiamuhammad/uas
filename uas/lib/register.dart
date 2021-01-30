import 'package:flutter/material.dart';
import 'package:uas/auth.dart';
import 'package:flutter/services.dart';
import 'package:uas/home.dart';
import 'package:uas/widget.dart';

class SignUp extends StatefulWidget {
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

final _formKey = GlobalKey<FormState>();

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();

  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService.signUpEmailAndPass(email, password).then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: appBar(context),
        elevation: 1.10,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Spacer(),
            TextFormField(
              validator: (val) {
                return val.isEmpty ? "Enter Emailid" : null;
              },
              decoration: InputDecoration(hintText: "email"),
              onChanged: (val) {
                email = val;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (val) {
                return val.isEmpty ? "Enter password" : null;
              },
              decoration: InputDecoration(hintText: "password"),
              onChanged: (val) {
                password = val;
              },
            ),
            TextFormField(
              validator: (val) {
                return val.isEmpty ? "Enter confirm password" : null;
              },
              decoration: InputDecoration(hintText: "password"),
              onChanged: (val) {
                email = val;
              },
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width - 48,
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dont have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  " Sign up",
                  style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
