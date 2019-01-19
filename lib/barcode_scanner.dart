import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
class BarcodeScanner extends StatefulWidget {

  @override
  BarcodeScannerState createState() {
    return new BarcodeScannerState();
  }
}

class BarcodeScannerState extends State<BarcodeScanner> {
String readCode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    startDelay(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Scan barcode',
          ),
        ),
        body: new Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Container(
                  color: Color.fromARGB(255, 66, 165, 245),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    child: new QrCamera(

                      qrCodeCallback: (code) {
                        if(readCode==null)
                        {
                          readCode = code;
                        print('Barcode is:- ' + code);
                        // callback(code);
                        Navigator.pop(context,code);//.pop(code);
                        // Navigator.of(context).pop();

                        // textController.text = code;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            new Container(
              height: 50,
              child: new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Or Type Barcode manually'),
              ),
            ),
          ],
        ));
  }
}

void startDelay(BuildContext context) {
  //  Future.delayed(const Duration(milliseconds: 10000), () {
  //   restartScan(context);
  //   print('called');
  //   return;
  // });
}

void restartScan(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Restart scan"),
          content: new Text("Do you want to restart scan?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             new FlatButton(
              child: new Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
