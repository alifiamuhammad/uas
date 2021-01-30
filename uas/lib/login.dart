import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uas/widget.dart';
import 'package:uas/auth.dart';
import 'package:uas/register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService authService = new AuthService();

  final _formKey = GlobalKey<FormState>();
  String email, password;

  bool loading = false;

  SignIn() async {
    if (_formKey.currentState.validate()) {

      set

     await authService.signInEmailAndPass(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: appBar(context),
        elevation: 1.10,
        backgroundColor: Colors.transparent,
      ),
      body: loading ? Container(
        child: Center(
        child: CircularProgressIndicator(),
        ),
      ):
       Form(
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
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width - 48,
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
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
