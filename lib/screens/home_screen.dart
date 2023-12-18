import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_app/Style.dart';
import 'package:portal_app/models/user.dart';
import 'package:portal_app/models/dashboard_data.dart';
import 'package:portal_app/screens/filter_screen.dart';
import 'package:http/http.dart' as http;
import 'package:portal_app/screens/login_screen.dart';
import 'package:portal_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NumberFormat formatter = NumberFormat.decimalPattern('hi');
  DashboardData data = new DashboardData();
  bool isLoading = true;
  Color color = primaryBlue;
  Future<void> fetchdata() async {
    var body = {
      "cooperative": AppConstants.COOPERATIVE,
      "id": widget.user.runningno
    };
    print(widget.user.toJson());
    final client = http.Client();
    final response = await client.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.DASHBOARD),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));
    print(response.body);
    if (jsonDecode(response.body)['message'] == "True") {
      data = DashboardData.fromJson(jsonDecode(response.body));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    if ((data.hargaBelian != "" && data.hargaBelian !=null) && (data.hargasemasa != ""&& data.hargasemasa !=null)) {
      double balance = 
          double.parse(data.hargasemasa!) - double.parse(data.hargaBelian!);
      if (balance == 0)
        color = primaryBlue;
      else if (balance < 0)
        color = Colors.red.shade900;
      else
        color = Colors.green.shade900;
    }
    if (!isLoading)
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                widget.user.name!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                widget.user.documentno!,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AppConstants.info.logo!,
          ),
          backgroundColor: Color(0xFFEFF5FB),
          elevation: 1,
          actions: [
            GestureDetector(
              onTap: () async {
                showAlertDialog(context);
              },
              child: Icon(
                Icons.power_settings_new,
                color: primaryBlue,
                size: 40,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            height: heightRatio(context, 100)-(MediaQuery.of(context).padding.top +
    MediaQuery.of(context).padding.bottom),
            color: Color(0xFFEFF5FB),
            child: Column(
              children: [
                Center(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      print("saasd");
                      await fetchdata();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Harga Pasaran Emas Pada",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                        color: primaryBlue,
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: widthRatio(context, 40),
                                                color: Colors.green[200],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Kami Beli (RM)",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 2),
                                                width: widthRatio(context, 40),
                                                color: Colors.red[200],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Kami Jual (RM)",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width:
                                                      widthRatio(context, 40),
                                                  color: Colors.blueGrey[100],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      double.parse(data
                                                              .drate![0]
                                                              .buyrate!)
                                                          .toStringAsFixed(2),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 2),
                                                  width:
                                                      widthRatio(context, 40),
                                                  color: Colors.blueGrey[100],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      double.parse(data
                                                              .drate![0]
                                                              .sellrate!)
                                                          .toStringAsFixed(2),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Nilai Emas (RM)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Mengikut Harga Semasa"),
                                              if (data.hargasemasa != "" &&
                                                  double.parse(
                                                          data.hargasemasa!) ==
                                                      0)
                                                Text("0.00")
                                              else if (data.hargasemasa != "")
                                                Text(formatter
                                                        .format(double.parse(
                                                            data.hargasemasa!))
                                                        .split(".")[0] +
                                                    "." +
                                                    formatter
                                                        .format(double.parse(
                                                            data.hargasemasa!))
                                                        .split(".")[1]
                                                        .substring(0, 2))
                                              else
                                                Text("0.00")
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Mengikut Harga Belian"),
                                              if (data.hargaBelian != "" &&
                                                  double.parse(
                                                          data.hargaBelian!) ==
                                                      0)
                                                Text("0.00")
                                              else if (data.hargaBelian != "")
                                                Text(formatter
                                                        .format(double.parse(
                                                            data.hargaBelian!))
                                                        .split(".")[0] +
                                                    "." +
                                                    formatter
                                                        .format(double.parse(
                                                            data.hargaBelian!))
                                                        .split(".")[1]
                                                        .substring(0, 2))
                                              else
                                                Text("0.00")
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Anggaran Kerugian",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  color: color,
                                                  child: data.hargaBelian !=
                                                              "" &&
                                                          data.hargasemasa != ""
                                                      ? Text(
                                                          formatter
                                                                  .format(double
                                                                          .parse(data
                                                                              .hargasemasa!) -
                                                                      double.parse(data
                                                                          .hargaBelian!))
                                                                  .split(
                                                                      ".")[0] +
                                                              "." +
                                                              formatter
                                                                  .format(double
                                                                          .parse(data
                                                                              .hargasemasa!) -
                                                                      double.parse(data
                                                                          .hargaBelian!))
                                                                  .split(".")[1]
                                                                  .substring(
                                                                      0, 2),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Text("0.00",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Tindakan",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      width: widthRatio(context, 60),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FilterScreen(
                                                        user: widget.user,
                                                      )));
                                        },
                                        child: Text("Penyata"),
                                        style: ButtonStyle(
                                          elevation: MaterialStateProperty.all(3),
                                          shape: MaterialStateProperty.all(
                                              StadiumBorder(
                                                  side: BorderSide(
                                                      color: Colors
                                                          .orange.shade400))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.orange.shade400),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jum. (G) Dlm. Akaun",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.yellow[400]),
                                      textAlign: TextAlign.left,
                                    ),
                                    Center(
                                      child: Container(
                                          width: widthRatio(context, 60),
                                          child: Text(
                                            double.parse(data.weight!)
                                                    .toStringAsFixed(5) +
                                                " (g)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )),
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
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppConstants.info.callingname!,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "BSKE - BUKU SIMPANAN KELANA EMAS",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          AppConstants.info.name!,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text("-----------"),
                        Text(
                          "Powered by",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("SoftInnovation Sdn. Bhd.",
                            style: TextStyle(fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    else
      return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("TIDAK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("YA"),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("userName");
      prefs.remove("password");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Adakah Anda lngin Keluar?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String formatAmount(String price) {
  String priceInText = "";
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}
