import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmationInformation(
                                  title: 'Confirm Information'),
                            ),
                          );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
