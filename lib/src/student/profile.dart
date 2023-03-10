import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';
import 'package:flutter/cupertino.dart';

import '../components/appbar.dart';
import '../helpers/button.dart';
import '../helpers/const_text.dart';
import '../helpers/spacer.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool isLoading = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _dateofjoiningController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _degreelevelController = TextEditingController();
    bool read_Only=true;
  Future _getdata() async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? values= prefs.getStringList("profile",);
    setState(() {
      isLoading = true;
    });
    try {
      
      var res =
      await api.StudentLogin(values![0],values[1]);
       if(res['codeStatus'] == true){
        _firstNameController.text=res['data']['first_name'].toString();
        _lastNameController.text=res['data']['last_name'].toString();
        _emailController.text=res['data']['email'].toString();
        _phoneController.text=res['data']['phone'].toString();
        _universityController.text=res['data']['university'].toString();
        _majorController.text=res['data']['major'].toString();
        _dateofjoiningController.text=res['data']['date_of_join'].toString();
        _dobController.text=res['data']['dob'].toString();
        _countryController.text=res['data']['country'].toString();
        _cityController.text=res['data']['city'].toString();
        _degreelevelController.text=res['data']['degree_level'].toString();
          // print(res['data']['degree_level'].runtimeType);
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
  }

    Future _updatedata() async{
    
    setState(() {
      isLoading = true;
    });
    try {
      
      var res =
      await api.studentUpdateNetwork({
        "student_id":USER_ID.toString(),
       'first_name': _firstNameController.text,
       'last_name':_lastNameController.text,
       'university':_universityController.text,
       'major':_majorController.text,
        'date_of_join':_dateofjoiningController.text,
          'dob':_dobController.text,
        'country':_countryController.text,
          'city':_cityController.text,
            'degree_level':_degreelevelController.text,
        'cv':'',
      });
       if(res['codeStatus'] == true){
        
        _getdata();
        print('inside true');
        showInSnackBar(LANGUAGE=='ENGLISH'?'Update Successfully':'???? ?????????????? ??????????');
setState(() {
  
read_Only=true;
});
// // 
       }else{
        showInSnackBar(LANGUAGE=='ENGLISH'?'Please Fill All Fields':'???? ???????? ???????? ???? ????????????',color: Colors.red);
        setState(() {
          isLoading=false;
        });
       }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      _showSnack('HTTP ERROR');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title:LANGUAGE=="ENGLISH"? "Profile":'???????? ????????????',back: true,
      action: TextButton(onPressed: (){
        setState(() {
          read_Only=false;
        });
      }, child: boldtext(Colors.white, 14,LANGUAGE=="ENGLISH"? "Edit":'????????')),
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal:read_Only?0: 30,) ,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:(isLoading)?const Center(child: CircularProgressIndicator(color: Colors.black,)): SingleChildScrollView(
          child:read_Only?Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
                child: Center(child: boldtext(Colors.white, 16,ACCOUNT_TYPE=="1"? LANGUAGE=='ENGLISH'?"VIP : Activated":'VIP: ????????':LANGUAGE=='ENGLISH'?"VIP : Pending":"VIP: ????????",center: true)),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration:const BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
                ),
                child: Column(
                  children: [
                    rowViewCard(context,LANGUAGE=='ENGLISH'? 'First Name':'?????????? ??????????', _firstNameController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'? 'Last Name':'?????? ??????????????', _lastNameController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'? 'Email':'???????? ????????????????', _emailController.text),
                    rowViewCard(context,LANGUAGE=='ENGLISH'? 'Phone:':'????????', _phoneController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'? 'University':'??????????', _universityController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'? 'Major':'??????????', _majorController.text),
                    rowViewCard(context,LANGUAGE=='ENGLISH'?'Degree Level':'?????????? ????????????', _degreelevelController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'? 'Date Of Joining':'?????????? ????????????????', _dateofjoiningController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'?'DOB':'?????????? ??????????????', _dobController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'?'Country':'????????', _countryController.text),
                    rowViewCard(context, LANGUAGE=='ENGLISH'?'City':'??????????', _cityController.text),
                  ],
                ),
              )
            ],
          ): Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(LANGUAGE=='ENGLISH'? 'First Name':'?????????? ??????????', Icons.person, _firstNameController),
                _buildTextField(LANGUAGE=='ENGLISH'? 'Last Name':'?????? ??????????????', Icons.person, _lastNameController),
                // _buildTextField('Email', Icons.email, _emailController),
                // _buildTextField('Phone', Icons.email, _phoneController),
                _buildTextField(LANGUAGE=='ENGLISH'? 'University':'??????????', Icons.home_work, _universityController),
                _buildTextField(LANGUAGE=='ENGLISH'? 'Major':'??????????', Icons.lock, _majorController),
                _buildTextField(LANGUAGE=='ENGLISH'?'Degree Level':'?????????? ????????????', Icons.lock, _degreelevelController,text: 'Degree Level'),
              _buildTextField(LANGUAGE=='ENGLISH'? 'Date Of Joining':'?????????? ????????????????', Icons.lock, _dateofjoiningController,text: 'Date Of Joining'),
              _buildTextField(LANGUAGE=='ENGLISH'?'DOB':'?????????? ??????????????', Icons.lock, _dobController,text: 'DOB'),
                // _buildTextField(LANGUAGE=='ENGLISH'?'Country':'????????', Icons.lock, _countryController),
                _buildTextField(LANGUAGE=='ENGLISH'?'City':'??????????', Icons.lock, _cityController,text:'City'),
                vertical(20),
                buttonmain(() {_updatedata() ; }, LANGUAGE=="ENGLISH"? "Update":'??????????', 0.5, context,),
                const SizedBox(height: 90.0),
                // _buildbackButton()
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

  Widget _buildTextField(String label, IconData icon, TextEditingController controller,{String?text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        autofocus:read_Only ,
          onTap: ()async {
            if (read_Only==false) {
              
          if (text=="City") {
           
            showdatepicker(controller,getcity: true);
          }
          if (text=="Date Of Joining"|| text=="DOB") {
            showdatepicker(controller);
          }
           if (text=='Degree Level') {
            opendgree(controller,);
          }
            }
        },
        readOnly: text=="Email"|| text=="Phone"||text=="Date Of Joining"|| text=="DOB"||text=="City"||text=='Degree Level'?true:false,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget _buildLoginButton() {
  //   return MaterialButton(

  //     minWidth: 200.0,
  //     height: 50.0,
  //     color: Colors.white,
  //     onPressed: _register,
  //     child: const Text(
  //       'Save',
  //       style: TextStyle(
  //         color: Colors.teal,
  //         fontSize: 20.0,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
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
              Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(1969, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        this.setState(() {
                          controller.text=newDateTime.toString().split(" ").first;
                        });
                      },
                    ),
                  ),
                  vertical(15),
                  buttonmain(() {
                    Navigator.pop(context);
                   }, "OK", 0.25, context),
                  vertical(15),
            ],
          ),
        ),
      );
    });
  }
   opendgree(TextEditingController controller){ showModalBottomSheet(isDismissible: false,
    backgroundColor: Colors.black.withOpacity(0.1),
    isScrollControlled: true,
      context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height*0.8,
          padding: const EdgeInsets.all(20),
          decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(25))
          ),
          child: Column(
              children: [
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Under Graduate':"?????? ????????????"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Under Graduate':"?????? ????????????";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Bachelor Degree':"???????? ?????????????????????? "),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? ' Bachelor Degree':"???????? ?????????????????????? ";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Masters':" ????????"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Masters':" ????????";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Phd Degree or higher':"?????? ????????????"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Phd Degree or higher':" ???????? ?????????????????? ???? ????????";
                    });
              Navigator.pop(context);
                  },
                ),
              ],
             )
          );
      });}

}

Widget rowViewCard(context, String text1,String text2,{Color?color,double?fsize}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
    child: Row(
      mainAxisAlignment:LANGUAGE=='ENGLISH'?  MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.35,
          child: boldtext(color??Colors.black45, fsize??12,LANGUAGE=='ENGLISH'? text1:text2),
        ),SizedBox(
          width: MediaQuery.of(context).size.width*0.45,child: Align(
            alignment:LANGUAGE=='ENGLISH'?Alignment.centerLeft: Alignment.centerRight,
            child: boldtext(color??Colors.black45, fsize??12,LANGUAGE=='ENGLISH'? text2:text1))),
      ],
    ),
  );
}