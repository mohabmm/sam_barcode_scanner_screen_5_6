import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';

class Completed extends StatefulWidget {
  Completed(
      {Key key,
      this.title,
      this.amount,
      this.paidTo,
      this.emitedBy,
      this.dueDate})
      : super(key: key);

  final String title;

  final String amount;
  final String paidTo;
  final String emitedBy;
  final String dueDate;

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  static GlobalKey previewContainer = new GlobalKey();
  static const androidMethodChannel =
      const MethodChannel('team.native.io/screenshot');

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final sixtyFiveHeight = height * 0.65;
    final FiveHeight = height * 0.07;

    final width = MediaQuery.of(context).size.width;
    final sixtyFiveWidth = width * 0.65;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment Receipt",
        ),
      ),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              height: sixtyFiveHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      top: BorderSide(color: Colors.black),
                      end: BorderSide(color: Colors.black),
                      start: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black))),
              margin: EdgeInsets.all(15),
              child: RepaintBoundary(
                key: previewContainer,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'Date: January 14th 2019',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                        new Text(
                          'Time: 4:30 PM',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: new IconButton(
                              icon: Icon(Icons.share),
                              onPressed: _screenShot,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: new Text(
                            "Amount:R\$" + widget.amount,
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Text(
                            'Paid By: John Smith ',
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        new Text(
                          'Bank: alt bank',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                        new Text(
                          'Branch:001',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                        new Text(
                          'Account: 1234-5',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Text(
                            'Paid to:' + widget.paidTo,
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Text(
                            'Emitted by:' + widget.emitedBy,
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Text(
                            'Due Date:' + widget.dueDate,
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new Text(
                            'Authintication code:',
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontSize: mediumText),
                          ),
                        ),
                        new Text(
                          '135658hgfgfdfd',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: mediumText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ButtonTheme(
                minWidth: sixtyFiveWidth,
                child: new RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "New Payment",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: new Container(
                width: sixtyFiveWidth,
                height: FiveHeight,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: new FlatButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: xLargeText,
                      ),
                      Container(
                        width: 6,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: xLargeText, color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    //sendRequest(textController.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _screenShot() async {
    print("called");
    try {
      //PermissionStatus res = await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
      //PermissionStatus res = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);

      print("called from try ");

      RenderRepaintBoundary boundary =
          previewContainer.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();

      final directory =
          (await getApplicationDocumentsDirectory()).parent.path + "/files";

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print('Screenshot Path:' + imgFile.path);
      await androidMethodChannel
          .invokeMethod('takeScreenshot', {'filePath': imgFile.path});
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }
}
