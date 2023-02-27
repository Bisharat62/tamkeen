import 'package:flutter/cupertino.dart';

Widget boldtext(
  Color tcolor,
  double tsize,
  String text, {
  bool? center,
}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        color: tcolor,
        fontSize: tsize,
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins_bold'),
  );
}

Widget regulartext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        color: tcolor, fontSize: tsize, fontFamily: 'poppins_regular'),
  );
}

Widget mediumtext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontFamily: 'poppins_medium'),
  );
}

Widget lighttext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontFamily: 'poppins_light'),
  );
}