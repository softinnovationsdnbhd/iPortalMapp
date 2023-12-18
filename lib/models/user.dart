import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int? cooperative;
  String? id;
  String? memberid;
  String? runningno;
  String? custstatus;
  String? customerstatus;
  String? isactive;
  String? salutation;
  String? salutationid;
  String? name;
  String? gender;
  String? documentno;
  String? doctype;
  String? documenttype;
  String? nationality;
  String? dob;
  String? hometel;
  String? mobile;
  String? permanantadd;
  String? permanantstate;
  String? state;
  String? permanantcity;
  String? city;
  String? permanantzip;
  String? bankname;
  String? bankaccno;
  String? emailid;
  String? username;
  String? password;
  String? beneficieryid;
  String? message;
  String? isSuccess;

  User(
      {this.cooperative,
      this.id,
      this.memberid,
      this.runningno,
      this.custstatus,
      this.customerstatus,
      this.salutationid,
      this.salutation,
      this.isactive,
      this.name,
      this.gender,
      this.documentno,
      this.doctype,
      this.documenttype,
      this.nationality,
      this.dob,
      this.hometel,
      this.mobile,
      this.permanantadd,
      this.permanantstate,
      this.state,
      this.permanantcity,
      this.city,
      this.permanantzip,
      this.bankname,
      this.bankaccno,
      this.emailid,
      this.username,
      this.password,
      this.beneficieryid,
      this.message,
      this.isSuccess});

  User.fromJson(Map<String, dynamic> json) {
    cooperative = json['cooperative'];
    id = json['id'];
    memberid = json['memberid'];
    runningno = json['runningno'];
    custstatus = json['custstatus'];
    customerstatus = json['customerstatus'];
    salutationid = json['salutationid'];
    salutation = json['salutation'];
    isactive = json['isactive'];
    name = json['name'];
    gender = json['gender'];
    documentno = json['documentno'];
    doctype = json['doctype'];
    documenttype = json['documenttype'];
    nationality = json['nationality'];
    dob = json['dob'];
    hometel = json['hometel'];
    mobile = json['mobile'];
    permanantadd = json['permanantadd'];
    permanantstate = json['permanantstate'];
    state = json['state'];
    permanantcity = json['permanantcity'];
    city = json['city'];
    permanantzip = json['permanantzip'];
    bankname = json['bankname'];
    bankaccno = json['bankaccno'];
    emailid = json['emailid'];
    username = json['username'];
    password = json['password'];
    beneficieryid = json['beneficieryid'];
    message = json['message'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cooperative'] = this.cooperative;
    data['id'] = this.id;
    data['memberid'] = this.memberid;
    data['runningno'] = this.runningno;
    data['custstatus'] = this.custstatus;
    data['customerstatus'] = this.customerstatus;
    data['salutationid'] = this.salutationid;
    data['salutation'] = this.salutation;
    data['isactive'] = this.isactive;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['documentno'] = this.documentno;
    data['doctype'] = this.doctype;
    data['documenttype'] = this.documenttype;
    data['nationality'] = this.nationality;
    data['dob'] = this.dob;
    data['hometel'] = this.hometel;
    data['mobile'] = this.mobile;
    data['permanantadd'] = this.permanantadd;
    data['permanantstate'] = this.permanantstate;
    data['state'] = this.state;
    data['permanantcity'] = this.permanantcity;
    data['city'] = this.city;
    data['permanantzip'] = this.permanantzip;
    data['bankname'] = this.bankname;
    data['bankaccno'] = this.bankaccno;
    data['emailid'] = this.emailid;
    data['username'] = this.username;
    data['password'] = this.password;
    data['beneficieryid'] = this.beneficieryid;
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

Future<User> userLogin(String userName, String password) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  var body = {"cooperative": 1040, "username": userName, "password": password};
  final client = http.Client();
  final response = await client.post(
      Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body));
  User _user = new User();
  if (jsonDecode(response.body)["isSuccess"].toString().toLowerCase() ==
      "true") {
    _user = User.fromJson(jsonDecode(response.body));
    _sharedPreferences.setString("userName", userName);
    _sharedPreferences.setString("password", password);
    return _user;
  }
  _user = User.fromJson(jsonDecode(response.body));
  return _user;
}
