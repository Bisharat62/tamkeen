import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/company/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/const_text.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'package:tamkeen_flu/src/student/dashboard.dart';

import 'components/sharePrefs.dart';
import 'helpers/button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    print(ROLE);
    return WillPopScope(
      onWillPop: ()async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ROLE=='student'?const studentDashboard():const CompanyDashboard())) ;
          return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ROLE=='student'?const studentDashboard():const CompanyDashboard()));
          }, icon:const Icon(Icons.arrow_back_ios_new_sharp)),
        ),
        // appBar: Appbar(title: LANGUAGE=="ENGLISH"?"Settings":"إعدادات",back: true,),
        body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldtext(Colors.black, 14,LANGUAGE=="ENGLISH"? "Logout":'تسجيل خروج'),
                  
                buttonmain(() {delete_prefs(context);
                 },LANGUAGE=="ENGLISH"?  "Logout":"تسجيل خروج", 0.35, context,height: 35)
                ],
              ),
              vertical(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldtext(Colors.black, 14,LANGUAGE=="ENGLISH"?  "Language":'لغة'),
                  DropdownButton<String>(
          items: <String>['ENGLISH', 'ARABIC',].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: boldtext(Colors.black,14,value)
            );
          }).toList(),
          hint: boldtext(Colors.white, 14, LANGUAGE.toString()),
          onChanged: (value2) {
            setState(() {
              LANGUAGE=value2;
            });
            updateLanguage(value2!);
          },
        )
           
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}