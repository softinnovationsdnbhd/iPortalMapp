class Member {
  String? memberid;
  String? customerstatus;
  String? salutation;
  String? isactive;
  String? name;
  String? gender;
  String? documentno;
  String? documenttype;
  String? dob;
  String? hometel;
  String? mobile;
  String? permanantadd;
  String? state;
  String? sELANGOR;
  String? city;
  String? hULUSELANGOR;
  String? permanantzip;
  String? bankname;
  String? bankaccno;
  String? emailid;
  String? message;
  String? isSuccess;

  Member(
      {this.memberid,
      this.customerstatus,
      this.salutation,
      this.isactive,
      this.name,
      this.gender,
      this.documentno,
      this.documenttype,
      this.dob,
      this.hometel,
      this.mobile,
      this.permanantadd,
      this.state,
      this.sELANGOR,
      this.city,
      this.hULUSELANGOR,
      this.permanantzip,
      this.bankname,
      this.bankaccno,
      this.emailid,
      this.message,
      this.isSuccess});

  Member.fromJson(Map<String, dynamic> json) {
    memberid = json['memberid'];
    customerstatus = json['customerstatus'];
    salutation = json['salutation'];
    isactive = json['isactive'];
    name = json['name'];
    gender = json['gender'];
    documentno = json['documentno'];
    documenttype = json['documenttype'];
    dob = json['dob'];
    hometel = json['hometel'];
    mobile = json['mobile'];
    permanantadd = json['permanantadd'];
    state = json['state'];
    sELANGOR = json['SELANGOR'];
    city = json['city'];
    hULUSELANGOR = json['HULU SELANGOR'];
    permanantzip = json['permanantzip'];
    bankname = json['bankname'];
    bankaccno = json['bankaccno'];
    emailid = json['emailid'];
    message = json['message'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberid'] = this.memberid;
    data['customerstatus'] = this.customerstatus;
    data['salutation'] = this.salutation;
    data['isactive'] = this.isactive;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['documentno'] = this.documentno;
    data['documenttype'] = this.documenttype;
    data['dob'] = this.dob;
    data['hometel'] = this.hometel;
    data['mobile'] = this.mobile;
    data['permanantadd'] = this.permanantadd;
    data['state'] = this.state;
    data['SELANGOR'] = this.sELANGOR;
    data['city'] = this.city;
    data['HULU SELANGOR'] = this.hULUSELANGOR;
    data['permanantzip'] = this.permanantzip;
    data['bankname'] = this.bankname;
    data['bankaccno'] = this.bankaccno;
    data['emailid'] = this.emailid;
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}
