import 'package:flutter/material.dart';
import 'package:prototype_upwork/enter_barcode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirm Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnterBarcode(title: 'Type In Bar Code'),
    );
  }
}
