import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portal_app/Style.dart';
import 'package:portal_app/models/user.dart';
import 'package:portal_app/screens/forgot_password.dart';
import 'package:portal_app/screens/home_screen.dart';
import 'package:portal_app/screens/signup_screen.dart';
import 'package:portal_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

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
                  // padding: const EdgeInsets.symmetric(horizontal:30),
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
                            "LOG MASUK KE AKAUN ANDA",
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
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
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
                                                      color: primaryBlue),
                                                ),
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
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lock,
                                            color: primaryBlue,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: TextFormField(
                                              cursorColor: primaryBlue,
                                              controller: password,
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
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: primaryBlue,
                                                    ),
                                                  ),
                                                  labelText: 'Kata Laluan'),
                                              keyboardType: TextInputType.text,
                                              obscureText: _isObscure,
                                            ),
                                          ),
                                        ],
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
                                              SharedPreferences
                                                  _sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              if(username.text.isEmpty){
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                    msg: "ID Pengguna mesti diisi",
                                                  );
                                              }
                                              else if(password.text.isEmpty){
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                    msg: "Kata Laluan mesti diisi",
                                                  );
                                              }
                                              else if (password.text.isNotEmpty &&
                                                  username.text.isNotEmpty) {
                                                User _user = await userLogin(
                                                    username.text,
                                                    password.text);
                                                if (_user.documentno != null) {
                                                  _sharedPreferences.setString(
                                                      "userName",
                                                      username.text);
                                                  _sharedPreferences.setString(
                                                      "password",
                                                      password.text);
                                                  context.loaderOverlay.hide();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                  user:
                                                                      _user)));
                                                } else {
                                                  username.text = "";
                                              password.text = "";
                                                  context.loaderOverlay.hide();
                                                  Fluttertoast.showToast(
                                                    msg: _user.message!,
                                                  );
                                                }
                                              } else {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "ID Pengguna / Kata Laluan",
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
                                            horizontal: 0, vertical: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignUpScreen()));
                                                },
                                                child: Text(
                                                  "Daftar",
                                                  style: TextStyle(
                                                      color: primaryBlue),
                                                )),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ForgotPasswordScreen()));
                                                },
                                                child: Text(
                                                  "Lupa Kata Laluan",
                                                  style: TextStyle(
                                                      color: primaryBlue),
                                                ))
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

showBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Invalid Credentials"),
            SizedBox(height: 10),
            ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      );
    },
  );
}
