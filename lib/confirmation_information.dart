import 'package:flutter/material.dart';
import 'package:prototype_upwork/enter_pin.dart';
import 'package:prototype_upwork/utils/const_widgets.dart';

class ConfirmationInformation extends StatefulWidget {
  ConfirmationInformation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConfirmationInformationState createState() =>
      _ConfirmationInformationState();
}

class _ConfirmationInformationState extends State<ConfirmationInformation> {
  bool today = true;
  bool dueDate = false;

  
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Now let\'s check if all the details are correct:',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: xLargeText),
              ),
              smallPaddingFromTop(),
              new Text(
                'You are paying:',
                style: new TextStyle(fontSize: smallText),
              ),
              smallPaddingFromTop(),
              new Text(
                'ELECTRICITY COMPANY',
                style: new TextStyle(fontSize: mediumText),
              ),
              xLargePaddingFromTop(),
              new TextField(
                style: new TextStyle(fontSize: largeText, color: Colors.black),
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                    border: new OutlineInputBorder(
                      
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    prefixText: 'R\$ ',
                    labelText: 'Amount',
                    labelStyle: new TextStyle(fontSize: smallText),
                    prefixStyle:
                        new TextStyle(color: Colors.black, fontSize: largeText),
                    hintText: '0.0'),
              ),
              xLargePaddingFromTop(),
              new Text(
                'Pay Date',
                style: new TextStyle(fontSize: smallText),
              ),
              smallPaddingFromTop(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: selected(today),
                      child: FlatButton(
                        child: Text(
                          'Today',
                          style:
                              TextStyle(fontSize: largeText, color: getcolor(today)),
                        ),
                        onPressed: () {
                          today = true;
                          dueDate = false;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: selected(dueDate),
                      child: FlatButton(
                        child: Text(
                          '22 Jan 2019',
                          style:
                              TextStyle(fontSize: largeText, color: getcolor(dueDate)),
                        ),
                        onPressed: () {
                          today = false;
                          dueDate = true;
                          setState(() {});
                        },
                      ),
                    ),
                  )
                ],
              ),
              new Container(
                height: 5,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      // child:Text('Today',style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '(Due Date)',
                        style: TextStyle(fontSize: xSmallText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                height: 10,
              ),
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
                              size: largeText,
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(
                              "Confirm",
                              style:
                                  TextStyle(fontSize: largeText, color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnterPin(
                                      title: 'Enter PIN',
                                    )),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              new Container(
                height: 10,
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: new FlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: largeText,
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(
                              "Back",
                              style:
                                  TextStyle(fontSize: largeText, color: Colors.white),
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
