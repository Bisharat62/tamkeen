import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/helpers/const_text.dart';
import 'package:flutter/cupertino.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool?back;
  Widget ?action;
   Appbar({super.key,required this.title,this.back,this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  back==true?IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon:const Icon(Icons.arrow_back_ios_new_rounded)):null,
      title: boldtext(Colors.white, 16, title),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [SizedBox(
        child: action,
      )],
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>const  Size.fromHeight(50);
}