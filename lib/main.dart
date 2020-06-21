import 'package:flutter/material.dart';
import 'package:paris/components/transaction_auth_dialog.dart';
import 'package:paris/screens/dashboard.dart';

void main() {
  runApp(BytebankApp());

}

class BytebankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
    ),
      home: TransactionAuthDialog()
    );
  }
}


