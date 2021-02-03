import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 22,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "DisneyHeroic")),
        TextSpan(
            text: 'Potion',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.redAccent[700])),
      ],
    ),
  );
}

Widget blackButton(BuildContext context, String label) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 48,
      child: Text(
        label,
        style: TextStyle(color: Colors.black),
      ));
}
