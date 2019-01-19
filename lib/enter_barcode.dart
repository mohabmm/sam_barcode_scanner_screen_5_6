import 'dart:_http';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_upwork/barcode_scanner.dart';
import 'package:prototype_upwork/confirmation_information.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';

class EnterBarcode extends StatefulWidget {
  EnterBarcode({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EnterBarcodeState createState() => _EnterBarcodeState();
}

class _EnterBarcodeState extends State<EnterBarcode> {
  var controller = new TextEditingController();

  var textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            tooltip: 'Scan',
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextField(
                controller: textController,
                style: new TextStyle(fontSize: largeText, color: Colors.black),
                keyboardType: TextInputType.number,
                maxLines: 1,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    labelStyle: new TextStyle(fontSize: smallText),
                    prefixStyle:
                        new TextStyle(color: Colors.black, fontSize: largeText),
                    hintText: 'Barcode number'),
              ),
              xLargePaddingFromTop(),
              new Text(
                'You can type your bar code here',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: mediumText),
              ),
              Padding(padding: EdgeInsets.only(top: 70)),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue,
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: new FlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                              size: xLargeText,
                            ),
                            Container(
                              width: 6,
                            ),
                            Text(
                              "Confirm",
                              style: TextStyle(
                                  fontSize: xLargeText, color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          sendRequest(textController.text);
                        },
                      ),
                    ),
                  )
                ],
              ),
              xLargePaddingFromTop(),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.red,
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: new FlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: xLargeText,
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: xLargeText, color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendRequest(String barcode) async {
    print(textController.text);
    Map map = {"barcodeNum": barcode};

    var url = 'http://localhost:4567/barcodeLookup';

    String response = await apiRequest(url, map);

    var data = json.decode(response);
    if (data['result'] == 'ok') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ConfirmationInformation(title: 'Confirm Information'),
        ),
      );
    } else {
      invalidBarcodeDialog();
    }
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  void invalidBarcodeDialog() {
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

  void openScanningScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScanner(),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarcodeScanner()),
    );

    sendRequest(result);

  }
}
