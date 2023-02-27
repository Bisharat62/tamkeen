import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';

import 'package:flutter/cupertino.dart';
import '../../components/globals.dart';
import '../../helpers/button.dart';

class ApplyToCompany extends StatefulWidget {
  String company_id;
   ApplyToCompany({super.key,required this.company_id});

  @override
  State<ApplyToCompany> createState() => _ApplyToCompanyState();
}

class _ApplyToCompanyState extends State<ApplyToCompany> {
  bool isLoading=false;
  submitform()async{
    try {
      var res=await api.StudentApplyToCompanyNetwork({
      "company_id":widget.company_id,
      "name":_nameController.text,
      "email":_emailController.text,
      "phone":_phoneController.text,
      "address":_addressController.text,});
      print(res);
      if (res['codeStatus']==true) {
        setState(() {
          isLoading=false;
        });
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _addressController.clear();
                showInSnackBar("Data Submitted");
      }
    } catch (e) {
      print(e.toString());
        setState(() {
          isLoading=false;
        });
        
                showInSnackBar("Error Try Again ");
    }
  }
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print(widget.company_id);
    return Scaffold(
      appBar: Appbar(title: LANGUAGE=='ENGLISH'? "apply":"يتقدم",back: true,),
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding:const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        child: SingleChildScrollView(
          child:isLoading?const Center(child: CircularProgressIndicator(color: Colors.black,)): Column(
            children: [
              _buildTextField(LANGUAGE=='ENGLISH'?"Name":'اسم', Icons.person, _nameController),
              _buildTextField(LANGUAGE=='ENGLISH'?"Email":'بريد إلكتروني', Icons.email, _emailController),
              _buildTextField(LANGUAGE=='ENGLISH'?"Phone":'هاتف', Icons.call, _phoneController),
              _buildTextField(LANGUAGE=='ENGLISH'?"Address":'عنوان', Icons.location_on_outlined, _addressController),
              vertical(35),
            buttonmain(() {
              if (_nameController.text.isEmpty||_emailController.text.isEmpty||_phoneController.text.isEmpty||_addressController.text.isEmpty) {
                showInSnackBar("Please fill all Fields",color: Colors.red);
              }else{
        setState(() {
          isLoading=true;
        });
                submitform();
              }
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ApplyToCompany()));
             }, LANGUAGE=='ENGLISH'?"submit":'يُقدِّم', 0.35, context,height: 35)
            ],
          ),
        ),
      ),
    );
  }
    Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
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
}