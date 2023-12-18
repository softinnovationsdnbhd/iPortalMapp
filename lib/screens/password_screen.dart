import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portal_app/Style.dart';
import 'package:http/http.dart' as http;
import 'package:portal_app/utils/app_constants.dart';

class PasswordScreen extends StatefulWidget {
  final String userName;
  final String id;
  const PasswordScreen({Key? key, required this.userName, required this.id})
      : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  DateTime date = DateTime.now();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirm = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    username.text = widget.userName;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFEFF5FB),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: heightRatio(context, 100) -
                      (MediaQuery.of(context).padding.top +
                          MediaQuery.of(context).padding.bottom),
                  child: Form(
                    child: Theme(
                      data: ThemeData(brightness: Brightness.light),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  height: widthRatio(context, 30),
                                  width: widthRatio(context, 30),
                                  child: AppConstants.info.logo!)),
                          Text(
                            "LUPA KATA LALUAN",
                            style: TextStyle(
                                fontSize: 20,
                                color: primaryBlue,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Colors.orange.shade600,
                                    ),
                                    top: BorderSide(
                                      width: 1,
                                      color: Colors.orange.shade600,
                                    ),
                                    left: BorderSide(
                                      width: 1,
                                      color: Colors.orange.shade600,
                                    ),
                                    right: BorderSide(
                                      width: 1,
                                      color: Colors.orange.shade600,
                                    ))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              readOnly: true,
                                              cursorColor: primaryBlue,
                                              controller: username,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: primaryBlue),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryBlue),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryBlue)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                labelText: 'ID Pengguna',
                                              ),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lock,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              controller: password,
                                              cursorColor: primaryBlue,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: primaryBlue),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryBlue),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryBlue)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                labelText: 'Kata Laluan',
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isObscure1 =
                                                          !_isObscure1;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _isObscure1
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: primaryBlue,
                                                  ),
                                                ),
                                              ),
                                              obscureText: _isObscure1,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.vpn_key,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              cursorColor: primaryBlue,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: primaryBlue),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryBlue),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryBlue)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                labelText: 'Sahkan Kata Laluan',
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isObscure = !_isObscure;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _isObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: primaryBlue,
                                                  ),
                                                ),
                                              ),
                                              obscureText: _isObscure,
                                              controller:
                                                  confirm, //editing controller of this TextField
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text(
                                        "Nota: Kata laluan harus mempunyai sekurang-kurangnya 8 huruf, satu huruf besar, satu nombor, dan satu huruf khas seperti !@#\$.",
                                        style: TextStyle(
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(60, 60),
                                              primary: primaryBlue,
                                              shape: const CircleBorder(),
                                            ),
                                            onPressed: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              context.loaderOverlay.show();
                                              if (password.text !=
                                                  confirm.text) {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Kata Laluan Dan Pengesahan\n Kata Laluan Tidak Sepadan",
                                                );
                                              } else if (!validateStructure(
                                                  password.text)) {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg: "Kata Laluan Tidak Sah",
                                                );
                                              } else if (
                                                  password.text.isNotEmpty &&
                                                  confirm.text.isNotEmpty) {
                                                var body = {
                                                  "cooperative":
                                                      AppConstants.COOPERATIVE,
                                                  "username": username.text,
                                                  "password": password.text,
                                                  "beneficieryid": widget.id
                                                };
                                                print(body);
                                                final client = http.Client();
                                                final response =
                                                    await client.post(
                                                        Uri.parse(AppConstants
                                                                .BASE_URL +
                                                            AppConstants
                                                                .SIGN_UP),
                                                        headers: {
                                                          'Content-Type':
                                                              'application/json'
                                                        },
                                                        body: jsonEncode(body));
                                                var res =
                                                    jsonDecode(response.body);
                                                if ((res['isSuccess']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "true")) {
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: res['message'],
                                                  );
                                                  Navigator.pop(context);
                                                } else {
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: res['message'],
                                                  );
                                                }
                                              } else {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg: "Kata Lalun mesti diisi",
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Kembali",
                                                  style: TextStyle(
                                                      color: primaryBlue),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    AppConstants.info.callingname!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "BSKE - BUKU SIMPANAN KELANA EMAS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    AppConstants.info.name!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text("-----------"),
                                  Text(
                                    "Powered by",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text("SoftInnovation Sdn. Bhd.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
