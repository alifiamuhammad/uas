import 'package:flutter/material.dart';
import 'package:uas/widget.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results(
      {@required this.correct, @required this.incorrect, @required this.total});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Dijawab ${widget.correct} benar ${widget.incorrect} salah",
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blackButton(
                    context: context,
                    label: "Menu Utama",
                    buttonWidth: MediaQuery.of(context).size.width / 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
