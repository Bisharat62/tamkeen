import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/authentication/login.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'package:flutter/cupertino.dart';

import '../components/globals.dart';
import '../helpers/globalSnackbar.dart';

class ResetPassword extends StatefulWidget {
  bool isCompany;
   ResetPassword({super.key,required this.isCompany});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  bool isLoading = false;

   _updatePass()async{
    
    setState(() {
      isLoading = true;
    });
    try {
      var res =widget.isCompany==true?
      await api.companyUpdatePassNetwork(_passwordController.text, _cpasswordController.text):await api.studentUpdatePassNetwork(_passwordController.text, _cpasswordController.text);
      
      print("res $res");
      if (res['codeStatus']==true) {
          showInSnackBar('${res['message']}');
      setState(() {
        isLoading=false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CommonLogin(isCompany: widget.isCompany,)));
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
    print(widget.isCompany);
    print('student');
    return Scaffold(
      appBar: Appbar(title: 'Reset Password'),
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
              _buildTextField('Password', Icons.lock, _passwordController),
              vertical(15),
              _buildTextField('Confirm Password', Icons.lock, _cpasswordController),
              vertical(30),
              _buildLoginButton(),
          ],
        ),
      ),
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
        if (_passwordController.text.isEmpty || _cpasswordController.text.isEmpty) {
          showInSnackBar('Fill All Field',color: Colors.red);
        }else if(_passwordController.text != _cpasswordController.text){
          
          showInSnackBar('Password And Confirm Password are not Same',color: Colors.red);
        }
        
        else{
          _updatePass();
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