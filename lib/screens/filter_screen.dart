import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portal_app/Style.dart';
import 'package:intl/intl.dart';
import 'package:portal_app/models/statement.dart';
import 'package:portal_app/models/user.dart';
import 'package:portal_app/utils/app_constants.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class FilterScreen extends StatefulWidget {
  final User user;
  const FilterScreen({Key? key, required this.user}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  static const IconData border_color_outlined = IconData(0xeee9, fontFamily: 'MaterialIcons');
  List<Statement> data = [];
  bool isLoading = true;
  DateTime toDateTime = DateTime.now();
  DateTime fromDateTime = DateTime.now().subtract(Duration(days: 30));
  String toDate = "";
  String toDate1 = DateFormat('MM-dd-yyyy').format(DateTime.now());
  String fromDate = "";
  String fromDate1 = DateFormat('MM-dd-yyyy')
      .format(DateTime.now().subtract(Duration(days: 30)));
  String headDate = DateFormat('dd/MM/yyyy')
      .format(DateTime.now().subtract(Duration(days: 30)));
  Future<void> fetchdata(String fromDate, String toDate) async {
    data = [];
    var body = {
      "cooperative": AppConstants.COOPERATIVE,
      "fromdt": fromDate,
      "todt": toDate,
      "documentno": widget.user.documentno
    };
    print(body);
    final client = http.Client();
    final response = await client.post(
        Uri.parse("http://sisbiportal.com:82/api/Statement"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));
    print(response.body);
    if (jsonDecode(response.body) != null &&
        jsonDecode(response.body).length != 0) {
      jsonDecode(response.body).forEach((e) {
        print(e);
        data.add(Statement.fromJson(e));
      });
      setState(() {
        isLoading = false;
      });
    }
    print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    toDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    fromDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 30)));
    fetchdata(fromDate1, toDate1);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _fromDateController = TextEditingController();
    _fromDateController.text = fromDate;
    TextEditingController _toDateController = TextEditingController();
    _toDateController.text = toDate;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            color:Color(0xFFEFF5FB),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      Container(
                        padding:EdgeInsets.only(left:10),
                        child: CircleAvatar(
                          backgroundColor:primaryBlue,
                          child: GestureDetector(
                            onTap: ()=> Navigator.pop(context),
                            child: Container(child: Icon(Icons.arrow_back,size: 30, color: Colors.white,))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: primaryBlue, width: 1.5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Penyata Akaun Anggota",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: primaryBlue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.grey.shade300,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: widthRatio(context, 70),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: widthRatio(context, 30),
                                        child: Text("Tarikh Dari")),
                                    Container(
                                        width: widthRatio(context, 30),
                                        child: Text("Hingga")),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: widthRatio(context, 30),
                                    child: Container(
                                      height: 15,
                                      child: TextField(
                                        style: TextStyle(color: primaryBlue),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primaryBlue),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primaryBlue),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        controller:
                                            _fromDateController, //editing controller of this TextField

                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: fromDateTime,
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));
                                          setState(() {
                                            if (pickedDate != null) {
                                              fromDate = DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate);
                                              fromDateTime = pickedDate;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: widthRatio(context, 30),
                                    child: Container(
                                      height: 15,
                                      child: TextField(
                                        style: TextStyle(color: primaryBlue),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primaryBlue),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primaryBlue),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        controller:
                                            _toDateController, //editing controller of this TextField

                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: toDateTime,
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));
                                          setState(() {
                                            if (pickedDate != null) {
                                              toDate = DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate);
                                              toDateTime = pickedDate;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(60, 60),
                                  primary: primaryBlue,
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                    headDate = DateFormat('dd/MM/yyyy')
                                        .format(fromDateTime);
                                    print(fromDate);
                                    // String _todat = DateTime.parse(DateFormat('dd-MM-yyyy').parse(_toDateController.text.toString()))
                                    String _toDate = DateFormat('MM-dd-yyyy')
                                        .format(toDateTime);
                                    String _fromdate = DateFormat('MM-dd-yyyy')
                                        .format(fromDateTime);
                                    fetchdata(_fromdate, _toDate);
                                  });
                                },
                                child: Icon(Icons.border_color_outlined),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: widthRatio(context, 30),
                                child: Text(
                                  "Tarikh",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                width: widthRatio(context, 34),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "No. Transaksi",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                  width: widthRatio(context, 36) - 10,
                                  child: Align(
                                    child: Text(
                                      "Beli/Jual (g)",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.end,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Keterangan",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.start),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 10, left: 5),
                                    child: Text("Baki (g)",
                                        style: TextStyle(
                                            color: Colors.yellow[400],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700))),
                              ]),
                        ),
                      ],
                    ),
                  ),

                  !isLoading
                      ? Expanded(
                          child: RefreshIndicator(
                          onRefresh: () async {
                            fetchdata(fromDate, toDate);
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...List.generate(data.length, ((index) {
                                  if (index == 0)
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 1),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4),
                                        color: primaryBlue,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    width:
                                                        widthRatio(context, 30),
                                                    child: Text(
                                                      DateFormat('dd/MM/yyyy').format(fromDateTime),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        widthRatio(context, 34),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        data[index].receiptno!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                          data[index]
                                                              .description!,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.start),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            right: 10, left: 5),
                                                        child: Text(
                                                            double.parse(data[
                                                                        index]
                                                                    .weightdesc!)
                                                                .toStringAsFixed(
                                                                    5),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow[400],
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  if (double.parse(data[index].buy!) != 0)
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 1),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4),
                                        color: primaryBlue,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    width:
                                                        widthRatio(context, 30),
                                                    child: Text(
                                                      data[index]
                                                          .transactiondate!,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        widthRatio(context, 34),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        data[index].receiptno!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: widthRatio(
                                                              context, 36) -
                                                          10,
                                                      child: Align(
                                                        child: Text(
                                                          "B: " +
                                                              double.parse(
                                                                      data[index]
                                                                          .buy!)
                                                                  .toStringAsFixed(
                                                                      5),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                          data[index]
                                                              .description!,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.start),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            right: 10, left: 5),
                                                        child: Text(
                                                            double.parse(data[
                                                                        index]
                                                                    .weightdesc!)
                                                                .toStringAsFixed(
                                                                    5),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow[400],
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  if (double.parse(data[index].sell!) != 0)
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 1),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4),
                                        color: Color(0xFFEFF5FB),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    width:
                                                        widthRatio(context, 30),
                                                    child: Text(
                                                      data[index]
                                                          .transactiondate!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        widthRatio(context, 34),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        data[index].receiptno!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: widthRatio(
                                                              context, 36) -
                                                          10,
                                                      child: Align(
                                                        child: Text(
                                                          "J: " +
                                                              double.parse(
                                                                      data[index]
                                                                          .sell!)
                                                                  .toStringAsFixed(
                                                                      5),
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                          data[index]
                                                              .description!,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12),
                                                          textAlign:
                                                              TextAlign.start),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            right: 10, left: 5),
                                                        child: Text(
                                                            double.parse(data[
                                                                        index]
                                                                    .weightdesc!)
                                                                .toStringAsFixed(
                                                                    5),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green[800],
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  else
                                    return SizedBox();
                                })),
                              ],
                            ),
                          ),
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: primaryBlue,),
                        ),
                  // Container(
                  //   width: double.infinity,
                  //   child: DataTable(
                  //     // columnSpacing: 70,
                  //     headingRowColor: MaterialStateColor.resolveWith(
                  //         (states) => Colors.black),
                  //     dataRowColor:
                  //         MaterialStateColor.resolveWith((states) => primaryBlue),
                  //     columns: [
                  //       DataColumn(
                  //           label: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text('Tarikh',
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.white)),
                  //           Text('Keterangan',
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.white)),
                  //         ],
                  //       )),
                  //       DataColumn(
                  //           label: Text('No.\nTransaksi',
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.white))),
                  //       DataColumn(
                  //           label: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Text('Beli/Jual (g)',
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.white)),
                  //           Text('       Baki (g)',
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.yellow[400])),
                  //         ],
                  //       )),
                  //     ],
                  //     rows: [
                  //       ...List.generate(
                  //           data.length,
                  //           ((index) => DataRow(cells: [
                  //                 DataCell(Column(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     Text(data[index].transactiondate!,
                  //                         style: TextStyle(
                  //                             color: Colors.white, fontSize: 12)),
                  //                     Text(data[index].description!,
                  //                         style: TextStyle(
                  //                             color: Colors.white, fontSize: 12)),
                  //                   ],
                  //                 )),
                  //                 DataCell(Text(data[index].receiptno!,
                  //                     style: TextStyle(
                  //                         color: Colors.white, fontSize: 12))),
                  //                 DataCell(Text(data[index].weightdesc!,
                  //                     style: TextStyle(
                  //                         color: Colors.white, fontSize: 12))),
                  //               ]))),
                  //     ],
                  //   ),
                  // ),
                ])),
          ),
        ),
      ),
    );
  }
}
