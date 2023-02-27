import 'package:flutter/material.dart';
import '../../api.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
class verifyOtp extends StatefulWidget {
  final user_id;
  const verifyOtp({Key? key, this.user_id}) : super(key: key);

  @override
  State<verifyOtp> createState() => _verifyOtpState();
}

class _verifyOtpState extends State<verifyOtp> {
  @override
  bool isLoading = false;
  TextEditingController _otpController = TextEditingController();
  Future _checkOtp() async{
    setState(() {
      isLoading = true;
    });
    String _otp = _otpController.text;
    try {
      var res =
      await api.StudentVerify(widget.user_id.toString(),_otp.toString());
      if(res['codeStatus'] == true){
        _showSnack(res['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CommonLogin()),
        );
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

    goToSinup(){

    }

    // Do something with the email and password values
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
              Text(
                'Verify Your Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              _buildTextField('otp', Icons.email, _otpController),
              SizedBox(height: 30.0),
              (isLoading) ? CircularProgressIndicator() : _buildOtpButton(),
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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: _checkOtp,
      child: Text(
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
