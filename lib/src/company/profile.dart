import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/spacer.dart';
import 'package:flutter/cupertino.dart';

import '../components/sharePrefs.dart';
import '../helpers/button.dart';
import '../helpers/const_text.dart';
import '../helpers/globalSnackbar.dart';
import '../student/profile.dart';
class ProfileCompany extends StatefulWidget {
  const ProfileCompany({Key? key}) : super(key: key);

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {
  
  TextEditingController _NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController _webAddressController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController= TextEditingController();
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  bool read_Only=true;
  bool isLoading = false;
  getprofiledata()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if (prefs.getStringList("profile",)==null) {
       
     }else{
      
   List<String>?values= prefs.getStringList("profile",);
   _NameController.text=values![0];
   _webAddressController.text=values[1];
   _countryController.text=values[2];
   _cityController.text=values[3];
   _phoneController.text=values[4];
_emailController.text=values[5];
_addressController.text=values[6];
   setState(() {
     
   });
   
   print(values);
     }
  }

    Future _updatedata() async{
    
    setState(() {
      isLoading = true;
    });
    try {
      
      var res =
      await api.companyUpdateNetwork({
       'name': _NameController.text,
       'email':_emailController.text,
       'phone':_phoneController.text,
       'address':_addressController.text,
        'country':_countryController.text,
          'city':_cityController.text,
            'website_address':_webAddressController.text,
      });
      // print(res['codeStatus']);
      // [res['data']['name'].toString(),res['data']['website_address'].toString(),res['data']['country'].toString()
      //   ,res['data']['city'].toString(),res['data']['phone'].toString(),res['data']['email'].toString()
       if(res['codeStatus'] == true){
        print(res['data']);
        await saveProfileLoginDetails([res['data']['name'].toString(),res['data']['website_address'].toString(),res['data']['country'].toString(),res['data']['city'].toString()
        ,res['data']['city'].toString(),res['data']['phone'].toString(),res['data']['email'].toString()]);
        getprofiledata();
        showInSnackBar('Update Successfully,');
setState(() {
  
        isLoading = false;
read_Only=true;
});
// // 
       }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      showInSnackBar('HTTP ERROR',color: Colors.red);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofiledata();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: Appbar(title:LANGUAGE=="ENGLISH"? "Profile":'حساب تعريفي',back: true,
      action: TextButton(onPressed: (){
        setState(() {
          read_Only=false;
        });
        unitCodeCtrlFocusNode.requestFocus();
      }, child: boldtext(Colors.white, 14,LANGUAGE=="ENGLISH"? "Edit":'يحرر')),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal:read_Only?0: 30,) ,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child:isLoading?const Center(child: CircularProgressIndicator(color: Colors.black,)):read_Only?Column(
              children: [
                SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
                  child: Center(child: boldtext(Colors.white, 16,"${ _NameController.text}",center: true)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.69,
                  padding: const EdgeInsets.all(20),
                  decoration:const BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
                  ),
                  child: Column(
                    children: [
                      rowViewCard(context,LANGUAGE=='ENGLISH'?'Name':'اسم', _NameController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Email':'بريد إلكتروني', _emailController.text),
                      rowViewCard(context,LANGUAGE=='ENGLISH'?'Phone':'هاتف', _phoneController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Address':'عنوان', _addressController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Web Address':'عنوان صفحة انترنت', _webAddressController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'Country':'دولة', _countryController.text),
                      rowViewCard(context, LANGUAGE=='ENGLISH'?'City':'مدينة', _cityController.text),
                    ],
                  ),
                )
              ],
            ):  Column(
            children: [
              vertical(30),
              
                    const SizedBox(height: 10.0),
                    _buildTextField(LANGUAGE=='ENGLISH'?'Name':'اسم', Icons.email, _NameController),
                    _buildTextField(LANGUAGE=='ENGLISH'?'Address':'عنوان', Icons.location_on, _addressController),
                    _buildTextField(LANGUAGE=='ENGLISH'?'Web Address':'عنوان صفحة انترنت', Icons.lock, _webAddressController),
                    // _buildTextField(LANGUAGE=='ENGLISH'?'Country':'دولة', Icons.lock, _countryController),
                    _buildTextField(LANGUAGE=='ENGLISH'?'City':'مدينة', Icons.lock, _cityController,text:'City'),
                  vertical(20),
                  buttonmain(() {_updatedata() ; },LANGUAGE=="ENGLISH"? "Update":'تحديث', 0.5, context,),
                    const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),

    );
  }
    Widget _buildTextField(String label, IconData icon, TextEditingController controller,{String?text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        // focusNode:unitCodeCtrlFocusNode,
            onTap: ()async {
            if (read_Only==false) {
              
          if (text=="City") {
           
            showdatepicker(controller,getcity: true);
          }
            }
        },
        autofocus:read_Only ,
        readOnly:  text=="City"?true:read_Only,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
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
        // print(snapshot.data["data"]);
        return ListView.builder(
          itemCount:snapshot.data!["data"].length,
          shrinkWrap: true,
          itemBuilder: (context,index){
          return ListTile(
        title: boldtext(Colors.black,13,"${snapshot.data["data"][index]["name"]}"),
        onTap: (){
          this.setState(() {
            controller.text=snapshot.data["data"][index]["name"].toString();
            Navigator.pop(context);
          });
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
