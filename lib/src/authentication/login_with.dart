import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/authentication/verify_otp.dart';
import 'package:tamkeen_flu/src/authentication/verify_otp_company.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/button.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
class LoginWith extends StatefulWidget {
  bool? isCompany;
   LoginWith({Key? key,this.isCompany}) : super(key: key);

  @override
  State<LoginWith> createState() => _LoginWithState();
}

class _LoginWithState extends State<LoginWith> {
  TextEditingController _emailController = TextEditingController();
  bool sendCode=false;
  bool isLoading=false;
  Future _loginCompany()async{
   setState(() {isLoading = true;});
    String email = _emailController.text;
    try {
      var res =
      await api.CompanyloginOtpNetwork(email.toString(),);
      print("res $res");
      if (res['codeStatus']==true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
        VerifyOtpCompany(user_id: res['data']['id'],res: res,isLoginWithotp: true,)));
        setState(() {isLoading=false;});
      }else{
        showInSnackBar(res['message'],color: Colors.red);
      }
      setState(() {isLoading = false;});
      
    } catch (e) {
      print(e.toString());
      setState(() { isLoading = false;});
      showInSnackBar('HTTP ERROR',color: Colors.red);
    }
}
  Future _loginStudenty()async{
   setState(() {isLoading = true;});
    String email = _emailController.text;
    try {
      var res =
      await api.StudentLoginWithOtp(email.toString(),);
      print("res $res");
      if (res['codeStatus']==true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
        verifyOtp(user_id: res['data']['id'],res: res,isLoginWithotp: true,)));
        setState(() {isLoading=false;});
      }else{
        showInSnackBar(res['message'],color: Colors.red);
      }
      setState(() {isLoading = false;});
      
    } catch (e) {
      print(e.toString());
      setState(() { isLoading = false;});
      showInSnackBar('HTTP ERROR',color: Colors.red);
    }
}
  @override
  Widget build(BuildContext context) {
  print(widget.isCompany);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding:const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color:  Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              width : 200,
              height : 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
             Text(
              LANGUAGE=="ENGLISH"?'Login':"تسجيل الدخول",
              style:const TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
           sendCode?Column(
            children: [
                  const SizedBox(height: 30.0),
                  _buildTextField(LANGUAGE=="ENGLISH"?'Email':"بريد إلكتروني", Icons.email, _emailController),
                  const SizedBox(height: 15.0),

            vertical(20),
            isLoading?const CircularProgressIndicator(): buttonmain(() { 
              if (_emailController.text.isEmpty) {
                showInSnackBar('Please Enter Email',color: Colors.red);
              }else{
              widget.isCompany==true?_loginCompany():_loginStudenty();

              }
            }, LANGUAGE=="ENGLISH"?'Send':"يرسل", 0.5, context),
            ],
           ):
            Column(
              children: [
            buttonmain(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CommonLogin(isCompany: widget.isCompany,))); },
               LANGUAGE=="ENGLISH"?'Login With Password':"تسجيل الدخول بكلمة مرور", 0.5, context),
            vertical(20),
            buttonmain(() { 
              setState(() {
                sendCode=true;
              });
            }, LANGUAGE=="ENGLISH"?'Login With Otp':"Otp  تسجيل الدخول مع ", 0.5, context),

              ],
            ),
            // _buildLoginButton(LANGUAGE=="ENGLISH"?'Login With Password':"تسجيل الدخول كشركة", Colors.black.withOpacity(0.7), CommonLogin(isCompany: true,)),
            // const SizedBox(height: 20.0),
            // _buildLoginButton(LANGUAGE=="ENGLISH"?'Login With Otp':"تسجيل الدخول كطالب", Colors.black.withOpacity(0.7), CommonLogin()),
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
  Widget _buildLoginButton(String text, Color color, Widget nextPage) {
    return MaterialButton(
      minWidth: 200.0,
      height: 50.0,
      color: color,
      clipBehavior: Clip.hardEdge,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
