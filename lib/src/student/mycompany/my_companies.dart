import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/student/mycompany/applicationview.dart';

import 'package:flutter/cupertino.dart';
import '../../components/appbar.dart';
import '../../components/assets.dart';
import '../../helpers/const_text.dart';
// myCompanies
class myCompanies extends StatefulWidget {
  const myCompanies({Key? key}) : super(key: key);

  @override
  State<myCompanies> createState() => _myCompaniesState();
}

class _myCompaniesState extends State<myCompanies> {
  bool isLoading=true;
  List<dynamic> ?list;
  getmyCompanies()async{
    // print(USER_ID);
    try {
       var res =
      await api.MyCompanytNetwork(USER_ID.toString());
      print("res $res");
      if (res['codeStatus']==true) {
        setState(() {
        list=res['data'];
          isLoading=false;
        });
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
    // TODO: implement initState
    super.initState();
    getmyCompanies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "My Company":'شركتي',back: true,),
      body: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
            child: Column(
              children: [
               list!.isEmpty?Center(child: boldtext(Colors.black, 13,LANGUAGE=='ENGLISH'? "No Data To Available":"لا توجد بيانات متاحة")): ListView.builder(
          
                  itemCount:list!.length ,
                  shrinkWrap: true,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding:const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:const  Offset(0, 3), // changes position of shadow
                          ),
                        ],),
                        child: ListTile(
                          leading: Image.asset(IMAGES.COMPANY,height: 30,),
                          title: boldtext(Colors.black, 14, list![index]['comp_name']),
                          subtitle:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // boldtext(Colors.black45, 14, "City    :  ${list![index]['city']}"),
                              // boldtext(Colors.black45, 14, "Website :  ${list![index]['website_address']}"),
                              boldtext(Colors.black45, 14,LANGUAGE=='ENGLISH'? "Email    :  ${list![index]['comp_email']}":'${list![index]['comp_email']}   : بريد إلكتروني '),
                              boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'?"Address :  ${list![index]['comp_address']}":'${list![index]['comp_address']} :       عنوان   '),
                            ],
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationView(application_id: list![index]['id']))),
                        ),
                      ),
                    );
                  }
                  ),
              ],
            ),
          )
      ),
    );
  }
   
    
}
