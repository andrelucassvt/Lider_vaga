import 'package:flutter/material.dart';

class CardInfo extends StatefulWidget {
  String texto;
  CardInfo({this.texto});
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue[900],width: 3)
        ),
        child: Center(
          child: Text(
            widget.texto,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15,color: Colors.blue[900]),)),
      ),
    );
  }
}