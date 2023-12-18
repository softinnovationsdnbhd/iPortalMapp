// ignore_for_file: non_constant_identifier_names

import 'package:portal_app/models/company_info.dart';
import 'package:portal_app/models/user.dart';

class AppConstants {
  static String BASE_URL = "http://sisbiportal.com:82/api";
  static String COMPANY_INFO = "/CompanyInfo";
  static String LOGIN = "/UserDetails";
  static String MEMBER_DETAILS = "/MemberDetails";
  static String FORGOT_PASSSWORD = "/ForgotPassword";
  static String SIGN_UP = "/SignUp";
  static String DASHBOARD = "/Dashboard";
  static String ACCOUNT_STATEMENT = "/Statement";
  static int COOPERATIVE = 1040;

  static CompanyInfo info = new CompanyInfo();
}
