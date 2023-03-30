// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

class Constants {
  static var base_URL = "https://tamkin-ksa.net/tamkin/api/v1/api/";
  // static var base_URL = "127.0.0.1/tamkeen/api/v1/api/";
  //https://tamkin-ksa.net/tamkin/api/v1/api/add_trainee_position
  static var StudentLoginApi = base_URL + 'student_login';
  static var StudentRegisterApi = base_URL + 'student_register';
  static var StudentVerifyApi = base_URL + 'student_verify_email';
  static var CompanyVerifyApi = base_URL + 'company_verify_email';
  static var StudentVipRequestApi = base_URL + 'student_request_for_vip';
  static var StudentDetails = base_URL + 'student_details';
  static var CompanyLoginApi = base_URL + 'company_login';
  static var CompanyRegisterApi = base_URL + 'company_register';
  static var GetAllCitiesApi = base_URL + 'get_all_cities';
  static String MyStudentApi = base_URL + "my_student";
  static String AllStudentApi = base_URL + "all_students";
  static String MyCompanyApi = base_URL + "my_company";
  static String AllCompanyApi = base_URL + "all_company";
  static String StudentDetailsApi = base_URL + "student_details";
  static String ApplyToMyCompanyApi = base_URL + "student_apply_to_company";
  static String CompanyDetailsApi = base_URL + "company_details";
  static String StudentApplyToCompanyApi =
      base_URL + "student_apply_to_company";
  static String ViewApplicationApi = base_URL + "view_application";
  static String StudentUpdateApi = base_URL + "update_student_profile";
  static String CompanyUpdateApi = base_URL + "update_company_profile";
  static String CompanyForgotPassApi = base_URL + "company_forgot_password";
  static String StudentForgotPassApi = base_URL + "student_forgot_password";
  static String CompanyUpdatePassApi = base_URL + "company_change_password";
  static String StudentUpdatePassApi = base_URL + "student_change_password";
  static String StudentLoginWithOtpUrl = base_URL + "student_login_with_otp";
  static String StudentLoginVerifyOtpUrl = base_URL + "student_login_veify_otp";
  static String CompanyLoginOtpUrl = base_URL + "company_login_with_otp";
  static String CompanyVerifyOtpUrl = base_URL + "company_login_veify_otp";
  //---------------------------------------------Position Apis URL---------------------------
  static String AddTraineePositionUrl = base_URL + "add_trainee_position";
  static String UpdateAppStatusUrl = base_URL + "updateApplicationStatus";
  static String GetApplicationsofStuUrl =
      base_URL + "getApplicationsOfStudents";

  static String GetAppliedPositionsUrl = base_URL + "getAppliedPositions";
  static String GetAllPositionsUrl = base_URL + "getAllPositions";

  //https://tamkin-ksa.net/tamkin/api/v1/api/getAllPositions
}
