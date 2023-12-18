import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portal_app/models/user.dart';
import 'package:portal_app/screens/home_screen.dart';
import 'package:portal_app/screens/login_screen.dart';
import 'package:portal_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  Future<Null> getSharedPrefs() async {
    User _user = new User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userName") != null &&
        prefs.getString("password") != null) {
      print(prefs.getString("password"));
      _user = await userLogin(
          prefs.getString("userName")!, prefs.getString("password")!);
      if(_user.documentno!=null && _user.documentno!="")
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    user: _user,
                  )));
      else
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      

    }
    else
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
// if(!isLogin)
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFEFF5FB),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Text("V " + AppConstants.info.version!),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          AppConstants.info.callingname!,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: AppConstants.info.logo!),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(AppConstants.info.callingname!,style: TextStyle(fontWeight: FontWeight.w700),),
                            Text("BSKE - BUKU SIMPANAN KELANA EMAS",style: TextStyle(fontWeight: FontWeight.w400),),
                            Text(AppConstants.info.name!,style: TextStyle(fontWeight: FontWeight.w400),),
                            Text("-----------"),
                            Text("Powered by", style: TextStyle(fontSize: 14),),
                            Text("SoftInnovation Sdn. Bhd.",style: TextStyle(fontWeight: FontWeight.w700))

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
