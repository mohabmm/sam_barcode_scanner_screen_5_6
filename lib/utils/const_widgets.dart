import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double xLargeText = 22;
double largeText = 20;
double mediumText = 18;
double smallText = 16;
double xSmallText = 14;

smallPaddingFromTop() {
  return Padding(padding: EdgeInsets.only(top: 5));
}

mediumPaddingFromTop() {
  return Padding(padding: EdgeInsets.only(top: 10));
}

largePaddingFromTop() {
  return Padding(padding: EdgeInsets.only(top: 15));
}

xLargePaddingFromTop() {
  return Padding(padding: EdgeInsets.only(top: 20));
}

setLandscap()
{
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
}

setPotrait()
{
  SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitDown,
   DeviceOrientation.portraitUp,
]);
}


selected(bool selected) {
  if (selected) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
        border: Border.all(color: Colors.black, width: 1.0));
  } else {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey,
        border: Border.all(color: Colors.black, width: 1.0));
  }
}

getcolor(bool selected) {
  if (selected)
    return Colors.white;
  else
    return Colors.black;
}
