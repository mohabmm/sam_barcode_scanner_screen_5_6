import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fzxing/fzxing.dart';
import 'package:prototype_upwork/confirmation_information.dart';
import 'package:prototype_upwork/scan_qr/barcode_scanner.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';

typedef SendCallback = void Function(bool valid);

class EnterBarcode extends StatefulWidget {
  EnterBarcode({Key key, this.title, this.isValid}) : super(key: key);

  final String title;
  final SendCallback isValid;

  @override
  _EnterBarcodeState createState() => _EnterBarcodeState();
}

class _EnterBarcodeState extends State<EnterBarcode> {
  var controller = new TextEditingController();

  bool status;
  var textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // textController.text = '03399033204451350000740106501014977770000280385';
  }

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
              if (Platform.isAndroid) {
                _scan();
              } else {
                _navigateAndDisplaySelection(context);
              }
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
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
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
    if (barcode.length > 0) {
      Map map = {"barcodeNum": barcode};

      var url = 'http://localhost:4567/barcodeLookup';

      // this one is recommended to use if you are testing on Emulator
      //var url = 'http://' + '10.0.2.2' + ':4567/barcodeLookup';

      String response = await apiRequest(url, map);

      print('Response status: ${response}');
      print('Response body: ${response}');

      var data = json.decode(response);
      if (data['result'] == 'ok') {
        print("the data result is " + data['result']);

        if (data['variableAmount'] == true) {
          print("the data variableAmount is " +
              data['variableAmount'].toString());

          status = true;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmationInformation(true)),
          );
        } else {
          status = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmationInformation(false)),
          );
          print("the data variableAmount is " +
              data['variableAmount'].toString());
        }
        widget.isValid(true);
        //Navigator.of(context).pushNamed('/confirmationInformation');
      } else {
        print("nottokkkk");

        // widget.isValid(false);
        invalidBarcodeDialog();
      }
    }
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    print("the json map is " + jsonMap.toString());

    print(url);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print("the response is " + response.toString());
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

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarcodeScanner()),
    );
    textController.text = result;
    sendRequest(result);
  }

  Future<Null> _scan() async {
    List<String> _barcode;
    try {
      Fzxing.scan(isBeep: true, isContinuous: false).then((barcodeResult) {
        print("flutter size:" + barcodeResult?.toString());
        setState(() {
          _barcode = barcodeResult;
          textController.text = _barcode[0];
          sendRequest(_barcode[0]);
        });
      });
    } on PlatformException {
      _barcode.add('Failed to get barcode.');
    }
  }
}
