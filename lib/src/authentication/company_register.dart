import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';
import 'package:flutter/cupertino.dart';
import '../../api.dart';
import '../helpers/const_text.dart';
import 'verify_otp_company.dart';
import 'login.dart';
class CompanyRegister extends StatefulWidget {
  const CompanyRegister({Key? key}) : super(key: key);

  @override
  State<CompanyRegister> createState() => _CompanyRegisterState();
}

class _CompanyRegisterState extends State<CompanyRegister> {
  @override
  bool isLoading = false;
  TextEditingController _NameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController _webAddressController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  Future _register() async{
    setState(() {
      isLoading = true;
    });
    try {
      var res =
      await api.companyRegisterNetwork({
        'email':_emailController.text,

'name':_NameController.text,
'address':_addressController.text,
'phone':_phoneController.text,
'password':_passwordController.text,
'cpassword':_cpasswordController.text,
'website_address':_webAddressController.text,
'country':_countryController.text,
'city':_cityController.text
      }
      );
      print(res);
      if(res['codeStatus'] == true){
        _showSnack(res['message']);
        var userId = res['data']['id'];
        print(userId);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerifyOtpCompany(user_id: userId,)),
        );
      }else{
        _showSnack(res['message']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {print(e.toString());
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
                  const SizedBox(height: 10.0),
                  _buildTextField(LANGUAGE=='ENGLISH'? 'Company Name ':'اسم', Icons.person, _NameController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Address':'عنوان', Icons.email, _addressController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Email':'بريد إلكتروني', Icons.email, _emailController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Phone':'هاتف', Icons.call, _phoneController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Web Address':'عنوان صفحة انترنت', Icons.lock, _webAddressController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Country':'دولة', Icons.lock, _countryController,text: 'Country'),
                  _buildTextField(LANGUAGE=='ENGLISH'?'City':'مدينة', Icons.lock, _cityController,text: 'City'),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Password':'كلمة المرور', Icons.email, _passwordController),
                  _buildTextField(LANGUAGE=='ENGLISH'?'Confirm Password':'تأكيد كلمة المرور', Icons.lock, _cpasswordController),
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
      child: TextField(onTap: ()async {
          if (text=="City") {
           
            showdatepicker(controller,);
          }
        },
        readOnly: text=="City"|| text=='Country'? true:false,
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
      onPressed: (){
        if (_NameController.text.isEmpty||_emailController.text.isEmpty||_phoneController.text.isEmpty||_passwordController.text.isEmpty||_cpasswordController.text.isEmpty
        ||_webAddressController.text.isEmpty||_countryController.text.isEmpty||_cityController.text.isEmpty) {
          showInSnackBar("Please fill all fields",color: Colors.red);
        }else{
          _register();
          // print(_countryController.text);
        }
      },
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
            context, MaterialPageRoute(builder: ((context) => CommonLogin(isCompany: true,))));
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
    showdatepicker(TextEditingController controller,){
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
          child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
        ),
      );
    });
  }
}
