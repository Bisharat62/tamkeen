import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/button.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'package:tamkeen_flu/src/student/profile.dart';
import 'package:flutter/cupertino.dart';

import 'apply_tocompany_form.dart';

class CompanyDetailsSC extends StatefulWidget {
  String company_id;
   CompanyDetailsSC({super.key,required this.company_id});

  @override
  State<CompanyDetailsSC> createState() => _CompanyDetailsSCState();
}

class _CompanyDetailsSCState extends State<CompanyDetailsSC> {
  bool isLoading=true;
  Map<String, dynamic> list={};
  getdetails()async{
    try {
       var res =
      await api.CompanyDetailsNetwork(widget.company_id);
      // print(res);
      if (res['codeStatus']==true) {
        setState(() {
        list=res['data'];
          isLoading=false;
        });
        //  print('list $list');
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
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "Company Details":"تفاصيل الشركة",back: true,),body:isLoading?const Center(child: CircularProgressIndicator()):
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            rowViewCard(context, LANGUAGE=='ENGLISH'?'Name':'اسم', list['name'].toString(),color: Colors.black,),
            rowViewCard(context,LANGUAGE=='ENGLISH'?'Email':'بريد إلكتروني', list['email'].toString(),color: Colors.black,),
            rowViewCard(context,LANGUAGE=='ENGLISH'?'Phone':'هاتف', list['phone'].toString(),color: Colors.black,),
            rowViewCard(context, LANGUAGE=='ENGLISH'?'Address':'عنوان', list['address'].toString(),color: Colors.black,),
            rowViewCard(context, LANGUAGE=='ENGLISH'?'Country':'دولة', list['country'].toString(),color: Colors.black,),
            rowViewCard(context, LANGUAGE=='ENGLISH'?'City':'مدينة', list['city'].toString(),color: Colors.black,),
            rowViewCard(context, LANGUAGE=='ENGLISH'?'Web Address':'عنوان صفحة انترنت', list['website_address'].toString(),color: Colors.black,),
            vertical(35),
            buttonmain(() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyToCompany(company_id: widget.company_id,)));
             },LANGUAGE=='ENGLISH'? "apply":"يتقدم", 0.35, context,height: 35)
          ],
        ),
      ) ,
    );
  }
}