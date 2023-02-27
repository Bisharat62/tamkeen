import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/company/search_student_details.dart';
import 'package:tamkeen_flu/src/components/globals.dart';

import 'package:flutter/cupertino.dart';
import '../components/appbar.dart';
import '../helpers/const_text.dart';
import '../helpers/spacer.dart';
// SearchStudent
class SearchStudent extends StatefulWidget {
  const SearchStudent({Key? key}) : super(key: key);

  @override
  State<SearchStudent> createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  bool isLoading=true;
  List<dynamic> ?list;
  List<dynamic> searchlist=[];
  String _searchQuery = '';
  String filterSearch="first_name";
  TextEditingController city=TextEditingController();
  TextEditingController filter=TextEditingController();
  TextEditingController search=TextEditingController();
  searching(){
    setState(() {
      isLoading=true;
    });
    print("SearchQuery $_searchQuery");
   
    if (city.text.isNotEmpty) {
    searchlist=list!.where((element) =>element['city']==city.text).toList();
    }
    if(_searchQuery.isNotEmpty &&_searchQuery!=""){

    searchlist=list!.where((element) =>city.text.isEmpty? element[filterSearch].toLowerCase().contains(_searchQuery.toLowerCase()):element[filterSearch].toLowerCase().contains(_searchQuery.toLowerCase())&&element['city']==city.text).toList();
    }
    
    setState(() {
      isLoading=false;
    });
  }
 
  getSearchStudent()async{
    print(USER_ID);
    try {
       var res =
      await api.AllStudentNetwork();
      print("res $res");
      if (res['codeStatus']==true) {
        setState(() {
        list=res['data'];
        searchlist=res['data'];
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
    getSearchStudent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "Search Students":'البحث عن الطلاب',back: true,),
      body: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator()): Column(
            children: [
            Row(
              children: [
                textfield(city,LANGUAGE=='ENGLISH'? "City":'مدينة',text:"City" ),
                textfield(filter,LANGUAGE=='ENGLISH'? "Filter":'منقي',text:"Filter"),
                textfield(search,LANGUAGE=='ENGLISH'? "Search":'يبحث',text:"Search"),
              ],
            ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.75,
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount:searchlist.length ,
                  shrinkWrap: true,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 08),
                      child: ListTile(
                        leading: Icon(Icons.person,size: 40,color: Colors.black.withOpacity(0.7),),
                        title: boldtext(Colors.black, 14, searchlist[index]['first_name']),
                        subtitle: Column(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                          children: [
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'? 'Major    : ${searchlist[index]['major']}':'${searchlist[index]['major']}    :  رئيسي'),
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'?'City  :  ${searchlist[index]['city']}': '${searchlist[index]['city']}    :  مدينة'),
                          boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'? 'University    :     ${searchlist[index]['university']}':' ${searchlist[index]['university']}   :   جامعة'),
                          ],
                        ),
                        trailing:const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentDetailsScreen(student_id: list![index]['id']))),
                      ),
                    );
                  }
                  ),
              ),
              // Expanded(
              //   child: GridView.builder(
              //     padding: const EdgeInsets.all(16),
              //     itemCount: _filteredItems!.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 0.75,
              //     ),
              //     itemBuilder: (BuildContext context, int index) {
              //       return InkWell(
              //         onTap: () => {
              //           print(list![index]['id']),
              //           Navigator.push(context, MaterialPageRoute(builder: ((context) =>  StudentDetailsScreen(student_id:list![index]['id'] ,))))
              //         },
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //              Icon(Icons.person,size: 40,color: Colors.black.withOpacity(0.7),),
              //             const SizedBox(height: 8),
              //             Text(
              //               list![index]['first_name'],
              //               style: const TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16,
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          )
      ),
    );
  }
  textfield(TextEditingController controller,String hint,{String?text}){
    return   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*(text =="Search"?0.45:0.23),
                  height: 40,
                  child: TextField( onTap: ()async {
          if (text=="City") {
           
            showdatepicker(controller,getcity: true);
          }
          if (text=="Filter") {
            showdatepicker(controller);
          }
        },
        controller: controller,
        
        readOnly:text=="City"|| text=="Filter"?true:false,

                    decoration:  InputDecoration(
                      contentPadding:const EdgeInsets.only(top: 10,left: 10),
                      labelText: hint,
                      hintText: controller.text,
                      suffixIcon: text=="Search"?(_searchQuery.isEmpty)?const Icon(Icons.search):IconButton(onPressed: (){
                        this.setState(() {
                          filterSearch="first_name";
                          _searchQuery="";
                          searchlist=list!;
                        });
                        city.clear();
                        filter.clear();
                        search.clear();
                      }, icon:const Icon(Icons.close)):const Icon(Icons.arrow_drop_down_sharp),
                      // prefixIcon:const Icon(Icons.search),
                      border:const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (text=="Search") {
                        setState(() {
                          _searchQuery = value;

                        });
                        searching();
                      }
                    },
                  ),
                ),
              );
  }
    showdatepicker(TextEditingController controller,{bool ?getcity}){
     bool loader= true;
     dynamic list=[];
    showModalBottomSheet(isDismissible: false,
    backgroundColor: Colors.black.withOpacity(0.1),
    isScrollControlled: true,
      context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          padding: const EdgeInsets.all(20),
          decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(25))
          ),
          child: getcity==true?StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return FutureBuilder(
            future: api.get_all_cities(),
            builder: (context,snapshot){
      if (snapshot.hasData) {
        print(snapshot.data["data"]);
        return ListView.builder(
          itemCount:snapshot.data["data"].length,
          shrinkWrap: true,
          itemBuilder: (context,index){
          return ListTile(
        title: boldtext(Colors.black,13,"${snapshot.data["data"][index]["name"]}"),
        onTap: (){
          this.setState(() {
            controller.text=snapshot.data["data"][index]["name"].toString();
            Navigator.pop(context);
          });
          searching();
        },
          );
        });
      }else if(snapshot.hasError){
        return Text("${snapshot.error}");
      }
      return const Center(child: CircularProgressIndicator());
            }); 
          })
           : Column(
            children: [
                  vertical(15),
                  ListTile(
                    title: boldtext(Colors.black,13,"All"),
                    onTap: (){
                      this.setState(() {
                        controller.clear();
                        Navigator.pop(context);
                       });
                    },
                  ),
                  vertical(15),
                  ListTile(
                    title: boldtext(Colors.black,13,LANGUAGE=='ENGLISH'?"Student Name":'أسم الطالب'),
                    onTap: (){
                      this.setState(() {
                        controller.text=LANGUAGE=='ENGLISH'?"Student Name":'أسم الطالب';
                        
                        filterSearch="first_name";
                        Navigator.pop(context);
                       });
                        searching();
                    },
                  ),
                  vertical(15),
                  ListTile(
                    title: boldtext(Colors.black,13,LANGUAGE=='ENGLISH'?"University":'جامعة'),
                    onTap: (){
                      this.setState(() {
                        controller.text=LANGUAGE=='ENGLISH'?"University":'جامعة';
                        filterSearch="university";
                        Navigator.pop(context);
                       });
                        searching();
                    },
                  ),
                  vertical(15),
                  ListTile(
                    title: boldtext(Colors.black,13,LANGUAGE=='ENGLISH'?"Major":'رئيسي'),
                    onTap: (){
                      this.setState(() {
                        controller.text="Major";
                        filterSearch="major";
                        Navigator.pop(context);
                       });
                        searching();
                    },
                  ),
            ],
          ),
        ),
      );
    });
  }
}
