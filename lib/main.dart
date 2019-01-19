import 'package:flutter/material.dart';
import 'package:prototype_upwork/confirmation_information.dart';
import 'package:scanner_package/enter_barcode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirm Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/confirmationInformation': (BuildContext context) => ConfirmationInformation(
                        title: 'Confirmation Information',
                      ),
      },
      home: EnterBarcode(
        title: 'Type In Bar Code',
        isValid: (value) {
          if (value) {
            
          } else {
            invalidBarcodeDialog(context);
          }
          print('is valid $value');
        },
      ),
    );
  }

  void invalidBarcodeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Invalid barcode"),
            content: new Text("Please ente valid barcode"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
