import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portal_app/Style.dart';
import 'package:http/http.dart' as http;
import 'package:portal_app/screens/register_screen.dart';
import 'package:portal_app/utils/app_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController number = new TextEditingController();
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
                  height: heightRatio(context, 100)-(MediaQuery.of(context).padding.top +
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
                            "PENGAKTIFAN AKAUN",
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
                                            size: 30,
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
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              context.loaderOverlay.show();
                                              if (number.text.isNotEmpty) {
                                                var body = {
                                                  "cooperative":
                                                      AppConstants.COOPERATIVE,
                                                  "id": number.text,
                                                };
                                                print(body);
                                                final client = http.Client();
                                                final response =
                                                    await client.post(
                                                        Uri.parse(AppConstants
                                                                .BASE_URL +
                                                            AppConstants
                                                                .MEMBER_DETAILS),
                                                        headers: {
                                                          'Content-Type':
                                                              'application/json'
                                                        },
                                                        body: jsonEncode(body));
                                                var res =
                                                    jsonDecode(response.body);
                                                if (res[
                                                                'isSuccess']
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "true" &&
                                                    (res[
                                                                'username'] ==
                                                            "" ||
                                                        res[
                                                                'username'] ==
                                                            null)) {
                                                  String id =
                                                      res[
                                                          'runningno'];
                                                  context.loaderOverlay.hide();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterScreen(
                                                                  id: id)));
                                                } else {
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: res['message'],
                                                  );
                                                }
                                              } else {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Masukkan No. NRIC / No. Anggota",
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
