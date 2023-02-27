// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/authentication/company_register.dart';
import 'package:tamkeen_flu/src/authentication/forgotpassword.dart';
import 'package:tamkeen_flu/src/company/dashboard.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/const_text.dart';
import 'package:flutter/cupertino.dart';
import '../../api.dart';
import '../components/sharePrefs.dart';
import 'student_register.dart';
import '../student/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLogin extends StatefulWidget {
  bool? isCompany;
   CommonLogin({Key? key,this.isCompany}) : super(key: key);

  @override
  State<CommonLogin> createState() => _CommonLoginState();
}

class _CommonLoginState extends State<CommonLogin> {
  @override
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

 
Future _loginCompany()async{
   setState(() {
      isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    // print("$email $password");
    try {
      var res =
      await api.CompanyLoginNetwork(email.toString(),password.toString());
      // print("res $res");
      if (res['codeStatus']==true) {
        saveUserLoginDetails(res['data']['id'],res['data']['name'],res['data']['email'],res['data']['phone'],res['data']['status'],"company");
        await saveProfileLoginDetails([res['data']['name'].toString(),res['data']['website_address'].toString(),res['data']['country'].toString()
        ,res['data']['city'].toString(),res['data']['phone'].toString(),res['data']['email'].toString(),res['data']['address'].toString()]);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>const CompanyDashboard()));
        // print(res["data"]);
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
  Future _loginStudent() async{
    setState(() {
      isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      var res =
      await api.StudentLogin(email.toString(),password.toString());
      
      // print("res $res");
      if(res['codeStatus'] == true){
        _showSnack(LANGUAGE=='ENGLISH'?"login successfully":'تسجيل الدخول بنجاح');
        saveUserLoginDetails(res['data']['id'],res['data']['first_name'],res['data']['email'],res['data']['phone'],res['data']['account_type'],"student");
        saveUserProfileLoginDetails([email,password]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => const studentDashboard())));
      }else{
        _showSnack(res['message']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnack('HTTP ERROR');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
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
                   LANGUAGE=="ENGLISH"? 'Login':"تسجيل الدخول",
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  _buildTextField(LANGUAGE=="ENGLISH"?'Email':"بريد إلكتروني", Icons.email, _emailController),
                  const SizedBox(height: 15.0),
                  _buildTextField(LANGUAGE=="ENGLISH"?'Password':"كلمة المرور", Icons.lock, _passwordController),
                  // vertical(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(isCompany: widget.isCompany)));
                    }, child: boldtext(Colors.red, 13, LANGUAGE=='ENGLISH'?'Forgot Password ?':'هل نسيت كلمة السر ؟'))),
                  const SizedBox(height: 15.0),
                  (isLoading) ? const CircularProgressIndicator() : _buildLoginButton(),
                  const SizedBox(height: 30.0),
                  _buildSignupButton(),
                ],
              ),
            ),
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
  Widget _buildLoginButton() {
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed:widget.isCompany==true?_loginCompany: _loginStudent,
      child:  Text(
        LANGUAGE=='ENGLISH'?'Login':'تسجيل الدخول',
        style:const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>widget.isCompany==true?const CompanyRegister(): const StudentRegister()),
        );
      },
      child:  Text(
       LANGUAGE=='ENGLISH'? 'Register':'يسجل',
        style:const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


