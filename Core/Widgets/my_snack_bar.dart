import 'package:flutter/material.dart';

ScaffoldMessengerState mySnackBar(String message,BuildContext context){
  return               ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}