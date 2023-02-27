// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:tamkeen_flu/src/components/globals.dart';

import 'constants.dart';
import 'package:http/http.dart' as http;
class api {
  static Future StudentLogin(
      String email, String password) async {
    // print(query);
    var api_url = Constants.StudentLoginApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
      "password": password,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
  static Future CompanyLoginNetwork(String email,String password)async{
    var api_url=Constants.CompanyLoginApi;
    final response= await http.post(Uri.parse(api_url),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
      "password": password,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }

  static Future StudentRegister(
      Map<String,dynamic> values) async {
    var api_url = Constants.StudentRegisterApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "first_name": values["first_name"].toString(),
      "last_name": values["last_name"].toString() ,
      "email":  values["email"].toString(),
      "phone": values["phone"].toString() ,
      "password":  values["password"].toString(),
      "cpassword": values["cpassword"].toString() ,
          "university":values["university"].toString() ,
          "major":values["major"].toString() ,
          "date_of_join":values["date_of_join"].toString() ,
          "dob":values["dob"].toString() ,
          "country":values["country"].toString() ,
          "city":values["city"].toString() ,
          "degree_level":values["degree_level"].toString() ,
          "cv":values["cv"].toString()
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
  static Future companyRegisterNetwork(Map<String,dynamic> value)async{
    print(value);
    var api_url=Constants.CompanyRegisterApi;
    final response=await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email":value["email"],
'name':value["name"],
'phone':value["phone"],
'address':value["address"],
'password':value["password"],
'cpassword':value["cpassword"],
'website_address':value["website_address"],
'country':value["country"],
'city':value["city"],
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }

  static Future StudentVerify(
      String userId, String otp) async {
    // print(query);
    var api_url = Constants.StudentVerifyApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "user_id": userId,
      "otp": otp,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
    static Future CompanytVerify(
      String userId, String otp) async {
    print("$userId $otp");
    var api_url = Constants.CompanyVerifyApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "company_id": userId,
      "otp": otp,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }

  static Future StudentRequestVip(
      String userId) async {
    // print(query);
    var api_url = Constants.StudentVipRequestApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "user_id": userId,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }

  static Future getStudentByid(
      String userId) async {
    // print(query);
    var api_url = Constants.StudentDetails;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "user_id": userId,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
   static Future get_all_cities()async{
    var api_url=Constants.GetAllCitiesApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   
   //----------------------------------------------Company Side My Students And search Students Api---------------------------------------------------------------
   static Future MyStudentNetwork(String id)async{
     var api_url=Constants.MyStudentApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "company_id":id
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
     static Future AllStudentNetwork()async{
     var api_url=Constants.AllStudentApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "query":''
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Company Side Search Students Details-------
    static Future StudentDetailsNetwork(String id)async{
     var api_url=Constants.StudentDetailsApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "user_id":id
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Company Side My Students Details-------
    static Future ApplyToMyCompanyNetwork(Map<String,dynamic> value)async{
     var api_url=Constants.ApplyToMyCompanyApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "user_id":value["user_id"],
      "company_id":value["company_id"],
      "name":value["name"],
      "email":value["email"],
      "phone":value["phone"],
      "address":value["address"],
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Student Side My Company And search Company Api---------------------------------------------------------------
    static Future MyCompanytNetwork(String id)async{
     var api_url=Constants.MyCompanyApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "user_id":id
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
     static Future AllCompanyNetwork()async{
     var api_url=Constants.AllCompanyApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "query":''
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Student Side My Company Details-------
    static Future CompanyDetailsNetwork(String company_id)async{
     var api_url=Constants.CompanyDetailsApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "company_id":company_id,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Student Side My submit Form-------
    static Future StudentApplyToCompanyNetwork(Map<String,dynamic> values)async{
     var api_url=Constants.StudentApplyToCompanyApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "user_id":USER_ID,
      "company_id":values["company_id"],
      "name":values["name"],
      "email":values["email"],
      "phone":values["phone"],
      "address":values["address"],
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //----------------------------------------------Student Side My submit Form-------
    static Future ViewApllicationNetwork(String application_id)async{
     var api_url=Constants.ViewApplicationApi;
     final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },body: {
      "application_id":application_id,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
   }
   //-------------------------------------------------------------------------Update Profiles------------------------------------------------------------
    static Future studentUpdateNetwork(
      Map<String,dynamic> values) async {
    var api_url = Constants.StudentUpdateApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "student_id": values["student_id"].toString(),
      "first_name": values["first_name"].toString(),
      "last_name": values["last_name"].toString() ,
          "university":values["university"].toString() ,
          "major":values["major"].toString() ,
          "date_of_join":values["date_of_join"].toString() ,
          "dob":values["dob"].toString() ,
          "country":values["country"].toString() ,
          "city":values["city"].toString() ,
          "degree_level":values["degree_level"].toString() ,
          "cv":values["cv"].toString()
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
     static Future companyUpdateNetwork(
      Map<String,dynamic> values) async {
        print(values);
    var api_url = Constants.CompanyUpdateApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "company_id": USER_ID.toString(),
      "name": values["name"].toString(),
      "email": values["email"].toString() ,
          "phone":values["phone"].toString() ,
          'address':values["address"].toString() ,
          "country":values["country"].toString() ,
          "city":values["city"].toString() ,
          "website_address":values["website_address"].toString() ,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
  //--------------------------------------------------Close profile updates---------------------------------------------------------------
  
   //----------------------------------------------Forgot Password---------------------------------------------------------------
        static Future companyForgotPassNetwork(
      String email) async {
    var api_url = Constants.CompanyForgotPassApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }     static Future studentForgotPassNetwork(
      String email) async {
    var api_url = Constants.StudentForgotPassApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
    //----------------------------------------------Forgot Password---------------------------------------------------------------
        static Future companyUpdatePassNetwork( String pass, String cpass) async {
    var api_url = Constants.CompanyUpdatePassApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "company_id": USER_ID,
      "password": pass,
      "cpassword": cpass,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }     static Future studentUpdatePassNetwork(
      String pass, String cpass) async {
    var api_url = Constants.StudentUpdatePassApi;
    final response = await http.post(Uri.parse(api_url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "student_id": USER_ID,
      "password": pass,
      "cpassword": cpass,
    });
    final data = json.decode(response.body);
    return Future.delayed(const Duration(seconds: 2), () {
      return data;
    });
  }
}