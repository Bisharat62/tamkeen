// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamkeen_flu/src/company/dashboard.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/components/sharePrefs.dart';
import 'src/authentication/login_as.dart';
import 'src/student/dashboard.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkLanguage();
    checkLoginStatus();
  }
Future<void> checkLanguage()async{
  //1 name, 2 address, 3 webaddress , 4 country , 5 city
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("language",)!=null) {
      LANGUAGE=prefs.getString("language",);
    }else{
      LANGUAGE="ENGLISH";
    }
    

}
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("language",)!=null) {
      LANGUAGE=prefs.getString("language",);
    }else{
      LANGUAGE="ENGLISH";
    }
    if (prefs.getBool('is_logged_in')==null) {
    await Future.delayed(const Duration(milliseconds: 3500), () {
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginAs()));  });
    }else{
      await  getUserLoginDetails();
    await Future.delayed(const Duration(milliseconds: 3500), () {
           Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) =>ROLE=="student"?const studentDashboard():const CompanyDashboard()))); 
    });
    }
  }

  // NavigateToHome() async {
  //     // checkLoginStatus();
 
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width : 200,
          height : 200,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
