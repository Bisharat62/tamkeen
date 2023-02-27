import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/const_text.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'package:tamkeen_flu/src/student/profile.dart';
import 'package:flutter/cupertino.dart';

class ApplicationView extends StatefulWidget {
  String application_id;
   ApplicationView({super.key,required this.application_id});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  bool isLoading=true;
  Map<String, dynamic> list={};
   getdetails()async{
    try {
       var res =
      await api.ViewApllicationNetwork(widget.application_id);
      // print(res);
      if (res['codeStatus']==true) {
        setState(() {
        list=res['data'];
          isLoading=false;
        });
        //  print('list $list');
         print(res['data']['student']);
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
    print(widget.application_id);
    return Scaffold(
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "Application":'طلب',back: true,),
      body:isLoading?const Center(child: CircularProgressIndicator()): SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              vertical(30),
                boldtext(Colors.blue,14,LANGUAGE=='ENGLISH'?  "Application Details":'تفاصيل التطبيق'),
                vertical(20),
               rowViewCard(context,  LANGUAGE=='ENGLISH'?"Applied On :":':  تم التطبيق', "${list['application_details']["created"]}"),
                 rowViewCard(context,LANGUAGE=='ENGLISH'? "Student Name :":':  أسم الطالب', "${list['application_details']["stu_name"]}"),
                 rowViewCard(context,LANGUAGE=='ENGLISH'? "Student Email :":':   البريد الإلكتروني للطالب', "${list['application_details']["stu_email"]}"),
                 rowViewCard(context,LANGUAGE=='ENGLISH'? "Student Phone :":':   هاتف الطالب', "${list['application_details']["stu_phone"]}"),
                rowViewCard(context,LANGUAGE=='ENGLISH'?  "Student Address :":':   عنوان الطالب', "${list['application_details']["stu_address"]}"),
                
               const Divider(thickness: 2,),
              vertical(30),
                boldtext(Colors.blue,14,LANGUAGE=='ENGLISH'? "Company Details":'تفاصيل الشركة'),
                vertical(20),
                rowViewCard(context,LANGUAGE=='ENGLISH'? "Name :":'اسم', "${list['company']["name"]}"),
                rowViewCard(context, LANGUAGE=='ENGLISH'?"Email :":'بريد إلكتروني', "${list['company']["email"]}"),
                rowViewCard(context, LANGUAGE=='ENGLISH'?"Phone :":'هاتف', "${list['company']["phone"]}"),
                rowViewCard(context, LANGUAGE=='ENGLISH'?"Address :":'عنوان', "${list['company']["address"]}"),
                rowViewCard(context,LANGUAGE=='ENGLISH'? "Country :":'دولة', "${list['company']["country"]}"),
                rowViewCard(context, LANGUAGE=='ENGLISH'?"City :":'مدينة', "${list['company']["city"]}"),
                rowViewCard(context,LANGUAGE=='ENGLISH'? "Website :":'عنوان صفحة انترنت', "${list['company']["website_address"]}"),
                vertical(10),
              //  const Divider(thickness: 2,),
              // vertical(30),
              //   boldtext(Colors.blue,14, "Student Detais"),
              //   vertical(20),
              //   rowViewCard(context, "First Name :", "${list['student']["first_name"]}"),
              //   rowViewCard(context, "Last Name :", "${list['student']["last_name"]}"),
              //   rowViewCard(context, "Email :", "${list['student']["email"]}"),
              //   rowViewCard(context, "Phone :", "${list['student']["phone"]}"),
              //   rowViewCard(context, "Address :", "${list['student']["address"]}"),
              //   rowViewCard(context, "University :", "${list['student']["university"]}"),
              //   rowViewCard(context, "Major :", "${list['student']["major"]}"),
              //   rowViewCard(context, "DOB :", "${list['student']["dob"]}"),
              //   rowViewCard(context, "Date of Join :", "${list['student']["date_of_join"]}"),
              //   rowViewCard(context, "Degree Level :", "${list['student']["degree_level"]}"),
              //   rowViewCard(context, "Country :", "${list['student']["country"]}"),
              //   rowViewCard(context, "City :", "${list['student']["city"]}"),
              //   vertical(25)
            ],
          ),
        ),
      ),
    );
  }
}