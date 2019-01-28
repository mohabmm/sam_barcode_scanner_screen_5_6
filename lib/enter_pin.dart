import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';
import 'package:prototype_upwork/utils/pin_entry_text_field.dart';

class EnterPin extends StatefulWidget {
  EnterPin({
    Key key,
    this.title,
    this.amount,
    this.paidTo,
    this.emittedBy,
    this.dueDate,
  }) : super(key: key);

  final String title;
  final String amount;
  final String paidTo;
  final String emittedBy;
  final String dueDate;

  @override
  _EnterPinState createState() =>
      _EnterPinState(amount, paidTo, emittedBy, dueDate);
}

class _EnterPinState extends State<EnterPin> {
  var controller = new TextEditingController();
  final String amount;
  final String paidTo;
  final String emittedBy;
  final String dueDate;

  _EnterPinState(this.amount, this.paidTo, this.emittedBy, this.dueDate);

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
          margin: EdgeInsets.only(top: 15, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Almost there! Please add your 6 digit PIN to confirm payment.',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: xLargeText),
              ),
              xLargePaddingFromTop(),
              PinCodeTextField(
                amount: widget.amount,
                paidTo: widget.paidTo,
                emitedBy: widget.emittedBy,
                dueDate: widget.dueDate,
                controller: controller,
                hideCharacter: true,
                highlight: false,
                textInputType: TextInputType.number,
                highlightColor: Colors.blue,
                defaultBorderColor: Colors.black,
                hasTextBorderColor: Colors.blue,
                maxLength: 6,
                pinTextStyle: TextStyle(fontSize: xLargeText),
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 500),
              ),
              xLargePaddingFromTop(),
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
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => Completed(
//                                      title: 'Process done',
//                                    )),
//                          );
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
