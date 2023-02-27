import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/globals.dart';

import '../components/appbar.dart';
import '../helpers/const_text.dart';
import '../student/mycompany/applicationview.dart';

import 'package:flutter/cupertino.dart';
class MyStudents extends StatefulWidget {
  const MyStudents({Key? key}) : super(key: key);

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  bool isLoading=true;
  List<dynamic> ?list;
  getmystudents()async{
    print(USER_ID);
    try {
       var res =
      await api.MyStudentNetwork(USER_ID.toString());
      print("res $res");
      if (res['codeStatus']==true) {
        setState(() {
        list=res['data'];
          isLoading=false;
        });
      }else{
        setState(() {
          print(res['message']);
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
    getmystudents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "My Students":'طلابي',back: true,),
      body: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator()): Column(
            children: [
             list!.isEmpty?Center(child: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'No Data Available':"لا تتوافر بيانات")): ListView.builder(

                itemCount:list!.length ,
                shrinkWrap: true,
                physics:const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 08),
                    child: ListTile(
                      leading: Icon(Icons.person,size: 40,color: Colors.black.withOpacity(0.7),),
                      title: boldtext(Colors.black, 14, list![index]['first_name']),
                      subtitle: Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'? 'Major    : ${list![index]['major']}':'${list![index]['major']}    :  رئيسي'),
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'?'City  :  ${list![index]['city']}': '${list![index]['city']}    :  مدينة'),
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'? 'University    :     ${list![index]['university']}':' ${list![index]['university']}   :   جامعة'),
                        ],
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationView(application_id: list![index]['id']))),
                    ),
                  );
                }
                ),
            ],
          )
      ),
    );
  }
}
