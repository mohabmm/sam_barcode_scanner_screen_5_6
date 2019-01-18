import 'package:flutter/material.dart';
import 'package:prototype_upwork/confirmation_information.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirm Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConfirmationInformation(title: 'Confirm Information'),
      // home: EnterPin(title: 'Enter Pin'),
    );
  }
}
