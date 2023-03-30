import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/authentication/verify_otp.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';

import '../components/globals.dart';
import 'verify_otp_company.dart';

class ForgotPassword extends StatefulWidget {
  bool? isCompany;
   ForgotPassword({super.key,required this.isCompany});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  _forgotPass()async{
    
    setState(() {
      isLoading = true;
    });
    String email = _emailController.text;
    try {
      var res =widget.isCompany==true?
      await api.companyForgotPassNetwork(email.toString()):await api.studentForgotPassNetwork(email);
      
      print("res $res");
      if (res['codeStatus']==true) {
      setState(() {
        USER_ID= res['data']['id'];
        isLoading=false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>widget.isCompany==true? VerifyOtpCompany(user_id: USER_ID,isForgot: true,):verifyOtp(user_id:USER_ID,isForgot: true,)));
      }else{
          showInSnackBar('${res['message']}',color: Colors.red);
      setState(() {
        isLoading=false;
      });}
    }catch  (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
          showInSnackBar('Http Error',color: Colors.red);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Forgot Password',back: true,),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding:const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
             
                  const SizedBox(height: 30.0),
                  _buildTextField(LANGUAGE=="ENGLISH"?'Email':"بريد إلكتروني", Icons.email, _emailController), 
                  vertical(20),
                  _buildLoginButton(),
            ],
          ),),
    );
  }
   
  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }
  Widget _buildLoginButton() {
    return(isLoading) ?  Center(child: Container(
      // color: Colors.black,
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(color: Colors.black,))) : MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed:(){
        if (_emailController.text.isEmpty) {
          showInSnackBar('Fill Email Field',color: Colors.red);
        }else{
          _forgotPass() ;
        }
      }
      
      ,
      child:  Text(
        LANGUAGE=='ENGLISH'?'Continue':'يكمل',
        style:const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}