import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:uas/database.dart';
import 'package:uas/question.dart';
import 'package:uas/widget.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();

  String quizImageUrl, quizTitle, quizDescription, quizId;

  DatabaseService databaseService = new DatabaseService();

  bool loading = false;

  CreateQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImageUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) => {
            setState(() {
              loading = false;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Question(quizId)));
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (val) =>
                          val.isEmpty ? "Enter image url" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Image url",
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz title" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz description" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz description",
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          CreateQuizOnline();
                        },
                        child: blackButton(
                            context: context, label: "Create Quiz")),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
