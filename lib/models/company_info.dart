import 'dart:convert';

import 'package:flutter/material.dart';

class CompanyInfo {
  int? cooperative;
  String? name;
  String? callingname;
  Image? logo;
  String? businessregno;
  String? url;
  String? version;

  CompanyInfo(
      {this.cooperative,
      this.name,
      this.callingname,
      this.logo,
      this.businessregno,
      this.url,
      this.version});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    cooperative = json['cooperative'];
    name = json['name'];
    callingname = json['callingname'];
    logo =Image.memory(base64Decode(json['logo'])) ;
    businessregno = json['businessregno'];
    url = json['url'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cooperative'] = this.cooperative;
    data['name'] = this.name;
    data['callingname'] = this.callingname;
    data['logo'] = this.logo;
    data['businessregno'] = this.businessregno;
    data['url'] = this.url;
    data['version'] = this.version;
    return data;
  }
}
