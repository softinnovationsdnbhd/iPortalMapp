import 'package:flutter/material.dart';

widthRatio(BuildContext context, percentage) {
  return MediaQuery.of(context).size.width * percentage / 100;
}

heightRatio(BuildContext context, percentage) {
  return MediaQuery.of(context).size.height * percentage / 100;
}

Color primaryBlue = Color(0xFFF014C8E);
