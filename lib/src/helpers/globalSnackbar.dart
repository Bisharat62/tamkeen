import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
double? totalheight;

void showInSnackBar(String value, {Color? color}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    backgroundColor: color ?? Colors.green,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    // margin: EdgeInsets.only(bottom: totalheight! - 85, right: 20, left: 20),
  );

  snackbarKey.currentState?.showSnackBar(snackBar);
}