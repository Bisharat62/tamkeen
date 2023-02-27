import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/components/assets.dart';
import 'package:tamkeen_flu/src/helpers/const_text.dart';
import 'package:tamkeen_flu/src/student/searchcompany/company_details_sc.dart';
import '../../../api.dart';
import 'package:flutter/cupertino.dart';

// class SearchCompany extends StatefulWidget {

import '../../components/appbar.dart';
import '../../components/globals.dart';
// SearchCompany
class SearchCompany extends StatefulWidget {
  const SearchCompany({Key? key}) : super(key: key);

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
  bool isLoading=true;
  List<dynamic> ?list;
  String _searchQuery = '';
  TextEditingController city=TextEditingController();
  TextEditingController search=TextEditingController();
  List<dynamic> searchlist=[];
    searching(){
    setState(() {
      isLoading=true;
    });
    print("SearchQuery $_searchQuery");
   
    if (city.text.isNotEmpty) {
    searchlist=list!.where((element) =>element['city']==city.text).toList();
    }
    if(_searchQuery.isNotEmpty &&_searchQuery!=""){

    searchlist=list!.where((element) =>city.text.isEmpty? element["name"].toLowerCase().contains(_searchQuery.toLowerCase())||
           element["city"].toLowerCase().contains(_searchQuery.toLowerCase())||
           element["website_address"].toLowerCase().contains(_searchQuery.toLowerCase())
    :
    element["name"].toLowerCase().contains(_searchQuery.toLowerCase())||
           element["website_address"].toLowerCase().contains(_searchQuery.toLowerCase())&&element['city']==city.text).toList();
    }
    
    setState(() {
      isLoading=false;
    });
  }
  getSearchCompany()async{
    // print(USER_ID);
    try {
       var res =
      await api.AllCompanyNetwork();
      if (res['codeStatus']==true) {
        // print(res['data']);
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
    getSearchCompany();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(title:LANGUAGE=='ENGLISH'? "Serarch Company":"شركة سرارك",back: true,),
      body: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
            child: Column(
              children: [
               Row(
                children: [
                  textfield(city, LANGUAGE=='ENGLISH'? "City":'مدينة',text:"City"),
                  textfield(search,LANGUAGE=='ENGLISH'? "Search":'يبحث',text:'Search'),
                ],
              ),
                searchlist.isEmpty?Center(child: boldtext(Colors.black, 12, "No Data Available")): ListView.builder(
          
                  itemCount:searchlist.length ,
                  shrinkWrap: true,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
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
                          title: boldtext(Colors.black, 14, searchlist[index]['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldtext(Colors.black45, 14,LANGUAGE=='ENGLISH'? "City    :  ${searchlist[index]['city']}":'${searchlist[index]['city']}   :  مدينة  '),
                              boldtext(Colors.black45, 14, LANGUAGE=='ENGLISH'?"Website :  ${searchlist[index]['website_address']}":'${searchlist[index]['website_address']}  : موقع إلكتروني   '),
                            ],
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyDetailsSC(company_id: list![index]['id']))),
                        ),
                      ),
                    );
                  }
                  ),
                // Expanded(
                //   child: GridView.builder(
                //     padding: const EdgeInsets.all(16),
                //     itemCount: _filteredItems!.length,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       crossAxisSpacing: 10,
                //       mainAxisSpacing: 10,
                //       childAspectRatio: 0.75,
                //     ),
                //     itemBuilder: (BuildContext context, int index) {
                //       return InkWell(
                //         onTap: () => {
                //           // Navigator.push(context, MaterialPageRoute(builder: ((context) => const viewMyCompany(application_id: 1,))))
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //              Icon(Icons.person,size: 40,color: Colors.black.withOpacity(0.7),),
                //             const SizedBox(height: 8),
                //             Text(
                //               list![index]['name'],
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
            ),
          )
      ),
    );
  }
   textfield(TextEditingController controller,String hint,{String?text}){
    return   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*(text =="Search"?0.6:0.3),
                  height: 40,
                  child: TextField( onTap: ()async {
          if (text=="City") {
           
            showdatepicker(controller,getcity: true);
          }
        },
        controller: controller,
        
        readOnly:text=="City"?true:false,

                    decoration:  InputDecoration(
                      contentPadding:const EdgeInsets.only(top: 10,left: 10),
                      labelText: hint,
                      hintText: controller.text,
                      suffixIcon: text=="Search"?(_searchQuery.isEmpty&&city.text.isEmpty)?const Icon(Icons.search):IconButton(onPressed: (){
                        this.setState(() {
                          _searchQuery="";
                          searchlist=list!;
                        });
                        city.clear();
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
  }showdatepicker(TextEditingController controller,{bool ?getcity}){
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
           :const SizedBox.shrink()
        ),
      );
    });
  }
}
