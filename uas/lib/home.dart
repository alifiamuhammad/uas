import 'package:flutter/material.dart';
import 'package:uas/database.dart';
import 'package:uas/login.dart';

import 'package:uas/widget.dart';
import 'package:uas/create.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      quizImage:
                          snapshot.data.documents[index].data["quizImageUrl"],
                      quizDesc: snapshot.data.documents[index].data["quizDesc"],
                      quiztitle:
                          snapshot.data.documents[index].data["quizTitle"],
                      quizId: snapshot.data.documents[index].data["quizId"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Create()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String quizImage;
  final String quiztitle;
  final String quizDesc;
  final String quizId;
  QuizTile(
      {@required this.quizImage,
      @required this.quiztitle,
      @required this.quizDesc,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 8),
          height: 150,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    quizImage,
                    width: MediaQuery.of(context).size.width - 48,
                    fit: BoxFit.cover,
                  )),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quiztitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        quizDesc,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
