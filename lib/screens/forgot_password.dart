import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portal_app/Style.dart';
import 'package:http/http.dart' as http;
import 'package:portal_app/screens/password_screen.dart';
import 'package:portal_app/utils/app_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  DateTime date = DateTime.now();
  TextEditingController number = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                                            Icons.qr_code,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              cursorColor: primaryBlue,
                                              controller: number,
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
                                                labelText:
                                                    'No Ahli /  No Dokumen',
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
                                            Icons.mail,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              controller: mail,
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
                                                labelText: 'E-Mel',
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
                                            Icons.calendar_month,
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
                                                labelText: 'Tarikh Lahir',
                                              ),
                                              controller:
                                                  dob, //editing controller of this TextField

                                              readOnly:
                                                  true, //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate: date,
                                                        firstDate: DateTime(
                                                            1900), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime.now());
                                                setState(() {
                                                  if (pickedDate != null) {
                                                    date = pickedDate;
                                                    dob.text = DateFormat('dd-MM-yyyy').format(date);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
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
                                              if (number.text.isNotEmpty &&
                                                  mail.text.isNotEmpty &&
                                                  dob.text.isNotEmpty) {
                                                var dob =
                                                    DateFormat('MM/dd/yyyy')
                                                        .format(date)
                                                        .toString();
                                                var body = {
                                                  "cooperative":
                                                      AppConstants.COOPERATIVE,
                                                  "id": number.text,
                                                  "emailid": mail.text,
                                                  "dob": dob
                                                };
                                                print(body);
                                                final client = http.Client();
                                                final response = await client.post(
                                                    Uri.parse(AppConstants
                                                            .BASE_URL +
                                                        AppConstants
                                                            .FORGOT_PASSSWORD),
                                                    headers: {
                                                      'Content-Type':
                                                          'application/json'
                                                    },
                                                    body: jsonEncode(body));
                                                var res =
                                                    jsonDecode(response.body);
                                                if (res['isSuccess']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "true") {
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: res['message'],
                                                  );
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PasswordScreen(
                                                                userName: res[
                                                                    'username'],
                                                                id: res[
                                                                    'runningno'],
                                                              )));
                                                } else {
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: res['message'],
                                                  );
                                                }
                                              } else {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg: "Masukkan Semua Butiran",
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
