// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/authentication/login.dart';
import 'package:tamkeen_flu/src/authentication/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import '../../api.dart';
import '../company/dashboard.dart';
import '../components/sharePrefs.dart';
class VerifyOtpCompany extends StatefulWidget {
  final user_id;
  bool?isForgot;
  bool? isLoginWithotp;
  dynamic res;
   VerifyOtpCompany({Key? key, required this.user_id,this.isForgot,this.isLoginWithotp,this.res}) : super(key: key);

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
      var res =widget.isLoginWithotp==true?await api.CompanytVerifyOtpLogin(widget.user_id.toString(),_otp.toString()):
      await api.CompanytVerify(widget.user_id.toString(),_otp.toString());
      print(res);
      if(res['codeStatus'] == true){
        _showSnack(res['message']);
        if (widget.isLoginWithotp==true) {
          
        saveUserLoginDetails(widget.res['data']['id'],widget.res['data']['name'],widget.res['data']['email'],widget.res['data']['phone'],
        widget.res['data']['status'],"company");
        await saveProfileLoginDetails([widget.res['data']['name'].toString(),widget.res['data']['website_address'].toString(),widget.res['data']['country'].toString()
        ,widget.res['data']['city'].toString(),widget.res['data']['phone'].toString(),widget.res['data']['email'].toString(),widget.res['data']['address'].toString()]);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>widget.isLoginWithotp==true?CompanyDashboard() :widget.isForgot==true?ResetPassword(isCompany: true,) :CommonLogin(isCompany: true,)),
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
  }
  @override
  Widget build(BuildContext context) {
    print(widget.res);
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
