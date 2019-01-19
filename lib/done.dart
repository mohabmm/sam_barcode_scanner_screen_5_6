import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';

class Completed extends StatefulWidget {
  Completed({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
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
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Payment done. Thank you',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: xLargeText),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
