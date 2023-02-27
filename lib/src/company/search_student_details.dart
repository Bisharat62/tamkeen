import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/globals.dart';

import 'package:flutter/cupertino.dart';
import '../components/appbar.dart';
import '../student/profile.dart';

class StudentDetailsScreen extends StatefulWidget {
  String student_id;
   StudentDetailsScreen({super.key,required this.student_id});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  bool isLoading=true;
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _dateofjoiningController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _degreelevelController = TextEditingController();
  
  List<dynamic> ?list;
  getdetails()async{
      try {
       var res =
      await api.StudentDetailsNetwork(widget.student_id);
      print("res $res");
      if (res['codeStatus']==true) {
          _firstNameController.text=res['data']['first_name'].toString();
        _lastNameController.text=res['data']['last_name'].toString();
_emailController.text=res['data']['email'].toString();
_phoneController.text=res['data']['phone'].toString();
_addressController.text=res['data']['address'].toString();
_universityController.text=res['data']['university'].toString();
_majorController.text=res['data']['major'].toString();
_dateofjoiningController.text=res['data']['date_of_join'].toString();
_dobController.text=res['data']['dob'].toString();
_countryController.text=res['data']['country'].toString();
_cityController.text=res['data']['city'].toString();
_degreelevelController.text=res['data']['degree_level'].toString();
        setState(() {
        list=res['data'];
          isLoading=false;
        });
        print(list);
      }
    } catch (e) {
       setState(() {
          isLoading=false;
        });
      print(e.toString());
    }
  }
  @override
  void initState() { 
    super.initState();
    getdetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title:LANGUAGE=='ENGLISH'?"Student Details":'تفاصيل الطالب',back: true,),
      body:isLoading?const Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'First Name':'الاسم الأول', _firstNameController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'Last Name':'اسم العائلة', _lastNameController.text),
                      rowViewCard(context,LANGUAGE== 'ENGLISH'? 'Email':'بريد إلكتروني', _emailController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'Phone:':'هاتف', _phoneController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'Address':'عنوان', _addressController.text),
                      rowViewCard(context,LANGUAGE=='ENGLISH'? 'University':'جامعة', _universityController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'Major':'رئيسي', _majorController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Degree Level':'مستوى الدرجة', _degreelevelController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'? 'Date Of Joining':'تاريخ الالتحاق', _dateofjoiningController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'DOB':'تاريخ الميلاد', _dobController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Country':'دولة', _countryController.text),
                      rowViewCard(context,LANGUAGE=='ENGLISH'?'City':'مدينة', _cityController.text),
                      const SizedBox(height: 90.0),
            ],
          ),
        ),
      ),
    );
  }
    Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}