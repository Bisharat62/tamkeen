import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../components/globals.dart';
import '../helpers/button.dart';
import '../helpers/const_text.dart';
import '../helpers/spacer.dart';
import 'verify_otp.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
class StudentRegister extends StatefulWidget {
  const StudentRegister({Key? key}) : super(key: key);

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  bool isLoading = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _dateofjoiningController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _degreelevelController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();


  Future _register() async{
    setState(() {
      isLoading = true;
    });
    try {
      var res =
      await api.StudentRegister(
        {
          "first_name":_firstNameController.text,
          "last_name":_lastNameController.text,
          "email":_emailController.text,
          'skills_and_experience':_skillsController.text,
          "phone":_phoneController.text,
          "password":_passwordController.text,
          "cpassword":_cpasswordController.text,
          "university":_universityController.text,
          "major":_majorController.text,
          "date_of_join":_dateofjoiningController.text,
          "dob":_dobController.text,
          "country":_countryController.text,
          "city":_cityController.text,
          "degree_level":_degreelevelController.text,
          "cv":''
        }
      );
      print(res);
      if(res['codeStatus'] == true){
        _showSnack(res['message']);
        var userId = res['data']['id'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => verifyOtp(user_id: userId,)),
        );
      }else{
        _showSnack(res['message']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      _showSnack('HTTP ERROR');
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryController.text='Saudi Arabia';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                   LANGUAGE=='ENGLISH'? 'Register':'يسجل',
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'First Name':'الاسم الأول', Icons.email, _firstNameController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Last Name':'اسم العائلة', Icons.email, _lastNameController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Email':'بريد إلكتروني', Icons.email, _emailController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Phone:':'هاتف', Icons.email, _phoneController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'University':'جامعة', Icons.lock, _universityController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Major':'رئيسي', Icons.lock, _majorController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Skills And Experiance':'المهارات والخبرة', Icons.star, _skillsController,text: 'skills'),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Date Of Joining':'تاريخ الالتحاق', Icons.lock, _dateofjoiningController,text: 'Date Of Joining'),
                
                  _buildTextField(LANGUAGE=='ENGLISH'?'DOB':'تاريخ الميلاد', Icons.lock, _dobController,text: 'DOB'),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Country':'دولة', Icons.lock, _countryController,text: 'Country'),
                  _buildTextField(LANGUAGE=='ENGLISH'?'City':'مدينة', Icons.lock, _cityController,text: 'City'),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Degree Level':'مستوى الدرجة', Icons.lock, _degreelevelController,text: 'Degree Level'),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Password':'كلمة المرور', Icons.email, _passwordController),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Confirm Password':'تأكيد كلمة المرور', Icons.email, _cpasswordController),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  // boldtext(Colors.white, 14, "CV"),
                  // IconButton(onPressed: (){}, icon:const Icon(Icons.attach_file_sharp))
            
                  //   ],
                  // ),
                  const SizedBox(height: 30.0),
                  (isLoading) ? const CircularProgressIndicator() : _buildLoginButton(),
                  const SizedBox(height: 30.0),
                  _buildbackButton()
                ],
              ),
            ),
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
        maxLines: text=='skills'?3:1,
        onTap: ()async {
          if (text=="City") {
           
            showdatepicker(controller,getcity: true);
          }
          if (text=="Date Of Joining"|| text=="DOB") {
            showdatepicker(controller);
          }
          if (text=='Degree Level') {
            opendgree(controller,);
          }
        },
        readOnly: text=="Date Of Joining"|| text=="DOB" || text=="City"||text=='Country'|| text=='Degree Level'?true:false,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: _register,
      child:  Text(
                 LANGUAGE=='ENGLISH'? 'Register':'يسجل',
        style:const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildbackButton() {
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: (){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => CommonLogin())));
      },
      child:  Text(
       LANGUAGE=='ENGLISH'? 'Back To Login':'العودة إلى تسجيل الدخول',
        style:const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
// 
  showdatepicker(TextEditingController controller,{bool ?getcity,bool?degree}){
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
               },
            );
               });
             }else if(snapshot.hasError){
               return Text("${snapshot.error}");
             }
             return const Center(child: CircularProgressIndicator());
           }); 
            })
          
          
           :Column(
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
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Under Graduate':"تحت التخرج"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Under Graduate':"تحت التخرج";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Bachelor Degree':"درجة البكالوريوس "),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? ' Bachelor Degree':"درجة البكالوريوس ";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Masters':" سادة"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Masters':" سادة";
              Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: boldtext(Colors.black, 12,LANGUAGE=='ENGLISH'? 'Phd Degree or higher':"تحت التخرج"),
                  onTap: (){
                    this.setState(() {
                      controller.text=LANGUAGE=='ENGLISH'? 'Phd Degree or higher':" درجة الدكتوراه أو أعلى";
                    });
              Navigator.pop(context);
                  },
                ),
              ],
             )
          );
      });}
}

// degree==true?