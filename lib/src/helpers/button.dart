import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'const_text.dart';

Widget buttonmain(VoidCallback ontap, String text, double width, context,
    {double? height,
    Color? color,
    bool? noborder,
    Widget? child,
    double? fsize}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      width: MediaQuery.of(context).size.width * width,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular((noborder == true) ? 0 : 15),
      ),
      child: child ??
          Center(
            child: boldtext(Colors.white, fsize ?? 14, text),
          ),
    ),
  );
}