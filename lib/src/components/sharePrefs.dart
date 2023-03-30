// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamkeen_flu/src/authentication/login_as.dart';

import 'package:flutter/cupertino.dart';
import 'globals.dart';

delete_prefs(context)async{
  final _prefs=await SharedPreferences.getInstance();
  _prefs.clear();
  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginAs()));
}

 Future<void> saveUserLoginDetails(String user_id,String user_name,String user_email, String user_phone,  String accountType,String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    USER_ID=user_id;
    USER_NAME=user_name;
    USER_EMAIL=user_email;
    USER_PHONE=user_phone;
    ACCOUNT_TYPE=accountType;
    ROLE=role;
    prefs.setBool('is_logged_in', true);
    prefs.setString('user_id', user_id);
    prefs.setString('user_name', user_name);
    prefs.setString('user_email', user_email);
    prefs.setString('user_phone', user_phone);
    prefs.setString('account_type', accountType);
    prefs.setString('role', role);
  }
   Future<void> getUserLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    USER_ID= prefs.getString('user_id');
    USER_NAME=prefs.getString('user_name');
    USER_EMAIL=prefs.getString('user_id');
    USER_PHONE=prefs.getString('user_phone');
    ACCOUNT_TYPE=prefs.getString('account_type');
    ROLE=prefs.getString('role');
  }

Future<void> saveProfileLoginDetails(List<String> value)async{
  //1 name, 2 address, 3 webaddress , 4 country , 5 city,
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("profile", value);

}
Future<void> saveUserProfileLoginDetails(String value)async{
  //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("studentId", value);

}

Future<void> updateLanguage(String value)async{
  //1 name, 2 address, 3 webaddress , 4 country , 5 city
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", value);

}
