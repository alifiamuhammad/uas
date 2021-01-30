import 'package:flutter/material.dart';
import 'package:uas/login.dart';
import 'package:uas/register.dart';
import 'package:uas/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Container(
            height: 300,
            child: Image(
              image: AssetImage("images/welcome.jpg"),
              fit: BoxFit.contain,
            ),
          ),
          Container(
            child: Text(
              "Hello  you are Logged in as ",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
            onPressed: () {
              SignIn;
            },
            child: Text('Signout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          )
        ],
      ),
    ));
  }
}
