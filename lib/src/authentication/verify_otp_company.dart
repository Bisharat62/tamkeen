// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/authentication/login.dart';
import 'package:tamkeen_flu/src/authentication/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import '../../api.dart';
class VerifyOtpCompany extends StatefulWidget {
  final user_id;
  bool?isForgot;
   VerifyOtpCompany({Key? key, required this.user_id,this.isForgot}) : super(key: key);

  @override
  State<VerifyOtpCompany> createState() => _VerifyOtpCompanyState();
}

class _VerifyOtpCompanyState extends State<VerifyOtpCompany> {
  bool isLoading = false;
  final TextEditingController _otpController = TextEditingController();
  Future _checkOtp() async{
    setState(() {
      isLoading = true;
    });
    String _otp = _otpController.text;
    try {
      var res =
      await api.CompanytVerify(widget.user_id.toString(),_otp.toString());
      print(res);
      if(res['codeStatus'] == true){
        _showSnack(res['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>widget.isForgot==true?ResetPassword(isCompany: true,) :CommonLogin(isCompany: true,)),
        );
      }else{
        _showSnack(res['message']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      _showSnack('HTTP ERROR');
    }

    // goToSinup(){

    // }

    // Do something with the email and password values
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify Your Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              _buildTextField('otp', Icons.email, _otpController),
              const SizedBox(height: 30.0),
               _buildOtpButton(),
            ],
          ),
        ),
      ),
    );
  }
  _showSnack(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  Widget _buildOtpButton() {
    return (isLoading) ?const SizedBox(
      width: 40,
      height: 40,
      child:  CircularProgressIndicator(color: Colors.black,)) :MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed:_checkOtp,
      //  (){
      //   print(_otpController.text);
      //   print(widget.user_id);
      //   ;
      // },
      child: const Text(
        'Verify',
        style: TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
