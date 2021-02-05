import 'package:flutter/material.dart';
import 'package:uas/database.dart';
import 'package:uas/widget.dart';

class Question extends StatefulWidget {
  final String quizId;
  Question(this.quizId);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool loading = false;
  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          loading = false;
        });
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
          iconTheme: IconThemeData(color: Colors.black),
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
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) =>
                            val.isEmpty ? "Enter the question" : null,
                        decoration: InputDecoration(
                          hintText: "Question",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) =>
                            val.isEmpty ? "this space cannot blank" : null,
                        decoration: InputDecoration(
                          hintText: "Option1 (correct answer)",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (val) {
                          option1 = val;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) =>
                            val.isEmpty ? "this space cannot blank" : null,
                        decoration: InputDecoration(
                          hintText: "Option2",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (val) {
                          option2 = val;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) =>
                            val.isEmpty ? "this space cannot blank" : null,
                        decoration: InputDecoration(
                          hintText: "Option3",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (val) {
                          option3 = val;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) =>
                            val.isEmpty ? "this space cannot blank" : null,
                        decoration: InputDecoration(
                          hintText: "Option4",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (val) {
                          option4 = val;
                        },
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: blackButton(
                                context: context,
                                label: "Submit",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadQuestionData();
                            },
                            child: blackButton(
                                context: context,
                                label: "Add Question",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )));
  }
}
