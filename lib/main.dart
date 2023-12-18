import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portal_app/Style.dart';
import 'package:portal_app/models/company_info.dart';
import 'package:portal_app/screens/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:portal_app/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GlobalLoaderOverlay(useDefaultLoading: false,overlayWidget: Center(child: CircularProgressIndicator(color: primaryBlue)), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  Future<void> fetchData() async {
    var body = {"cooperative": AppConstants.COOPERATIVE};
    final client = http.Client();
    final response = await client.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.COMPANY_INFO),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));
    if (jsonDecode(response.body)["isSuccess"] != "False") {
      AppConstants.info = CompanyInfo.fromJson(jsonDecode(response.body));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  // This widget is the root nmrof your application.
  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return MaterialApp(home: Scaffold(backgroundColor: Color(0xFFEFF5FB), body: Center(child: CircularProgressIndicator(color: primaryBlue,))));
    else
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
  }
}
