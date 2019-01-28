import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_upwork/done.dart';

typedef OnDone = void Function(String text);
typedef PinBoxDecoration = BoxDecoration Function(Color borderColor);

/// class to provide some standard PinBoxDecoration such as standard box or underlined
class ProvidedPinBoxDecoration {
  /// Default BoxDecoration
  static PinBoxDecoration defaultPinBoxDecoration = (Color borderColor) {
    return BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(const Radius.circular(5.0)));
  };

  /// Underlined BoxDecoration
  static PinBoxDecoration underlinedPinBoxDecoration = (Color borderColor) {
    return BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor, width: 2.0)));
  };
}

class ProvidedPinBoxTextAnimation {
  /// A combination of RotationTransition, DefaultTextStyleTransition, ScaleTransition
  static AnimatedSwitcherTransitionBuilder awesomeTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(
        child: DefaultTextStyleTransition(
          style: TextStyleTween(
                  begin: TextStyle(color: Colors.pink),
                  end: TextStyle(color: Colors.blue))
              .animate(animation),
          child: ScaleTransition(
            child: child,
            scale: animation,
          ),
        ),
        turns: animation);
  };

  /// Simple Scaling Transition
  static AnimatedSwitcherTransitionBuilder scalingTransition =
      (child, animation) {
    return ScaleTransition(
      child: child,
      scale: animation,
    );
  };

  /// No transition
  static AnimatedSwitcherTransitionBuilder defaultNoTransition =
      (Widget child, Animation<double> animation) {
    return child;
  };

  /// Rotate Transition
  static AnimatedSwitcherTransitionBuilder rotateTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(child: child, turns: animation);
  };
}

class PinCodeTextField extends StatefulWidget {
  final int maxLength;
  final bool obscureText;

  final TextEditingController controller;
  final TextInputFormatter inputFormatters;
  final bool hideCharacter;
  final bool highlight;
  final Color highlightColor;
  final Color defaultBorderColor;
  final PinBoxDecoration pinBoxDecoration;
  final String maskCharacter;
  final TextStyle pinTextStyle;
  final double pinBoxHeight;
  final double pinBoxWidth;
  final OnDone onDone;
  final TextInputType textInputType;
  final bool hasError;
  final Color errorBorderColor;
  final Color hasTextBorderColor;
  final BlacklistingTextInputFormatter blacklistingTextInputFormatter;
  final Function(String) onTextChanged;
  final AnimatedSwitcherTransitionBuilder pinTextAnimatedSwitcherTransition;
  final Duration pinTextAnimatedSwitcherDuration;
  final String amount;
  final String paidTo;
  final emitedBy;
  final String dueDate;

  const PinCodeTextField({
    this.amount,
    this.paidTo,
    this.emitedBy,
    this.dueDate,
    Key key,
    this.maxLength: 4,
    this.obscureText,
    this.blacklistingTextInputFormatter,
    this.textInputType,
    this.controller,
    this.inputFormatters,
    this.hideCharacter: true,
    this.highlight: false,
    this.highlightColor: Colors.black,
    this.pinBoxDecoration,
    this.maskCharacter: " ",
    this.pinBoxWidth: 45.0,
    this.pinBoxHeight: 45.0,
    this.pinTextStyle,
    this.onDone,
    this.defaultBorderColor: Colors.black,
    this.hasTextBorderColor: Colors.black,
    this.pinTextAnimatedSwitcherTransition,
    this.pinTextAnimatedSwitcherDuration: const Duration(),
    this.hasError: false,
    this.errorBorderColor: Colors.red,
    this.onTextChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PinCodeTextFieldState();
  }
}

class PinCodeTextFieldState extends State<PinCodeTextField> {
  FocusNode focusNode = new FocusNode();
  String text = "";
  int currentIndex = 0;
  List<String> strList = [];
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.maxLength; i++) {
      strList.add("");
    }

    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _touchPinBoxRow(),
          _fakeTextInput(),
        ],
      ),
    );
  }

  Widget _touchPinBoxRow() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (hasFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
          Future.delayed(Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(focusNode);
          });
        } else {
          FocusScope.of(context).requestFocus(focusNode);
        }
      },
      child: _pinBoxRow(context),
    );
  }

  Widget _fakeTextInput() {
    return Container(
      width: 0.1,
      height: 0.1,
      child: TextField(
        focusNode: focusNode,
        autofocus: true,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        controller: widget.controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.transparent,
        ),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        cursorColor: Colors.transparent,
        maxLength: widget.maxLength,
        onChanged: _onTextChanged,
        obscureText: true,
      ),
    );
  }

  void _onTextChanged(text) {
    if (widget.onTextChanged != null) {
      widget.onTextChanged(text);
    }

    setState(() {
      this.text = text;
      if (text.length < currentIndex) {
        strList[text.length] = "";
      } else {
        strList[text.length - 1] =
            widget.hideCharacter ? widget.maskCharacter : text[text.length - 1];
      }
      currentIndex = text.length;
    });
    if (text.length == widget.maxLength) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Completed(
                    title: 'Process done',
                    amount: widget.amount,
                    paidTo: widget.paidTo,
                    emitedBy: widget.emitedBy,
                    dueDate: widget.dueDate,
                  )),
        );
      });
    }
  }

  Widget _pinBoxRow(BuildContext context) {
    List<Widget> pinCodes = List.generate(widget.maxLength, (int i) {
      return _buildPinCode(i, context);
    });
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: pinCodes);
  }

  Widget _buildPinCode(int i, BuildContext context) {
    Color borderColor;
    BoxDecoration boxDecoration;
    if (widget.hasError) {
      borderColor = widget.errorBorderColor;
    } else if (widget.highlight &&
        hasFocus &&
        (i == text.length ||
            (i == text.length - 1 && text.length == widget.maxLength))) {
      borderColor = widget.highlightColor;
    } else if (i < text.length) {
      borderColor = widget.hasTextBorderColor;
    } else {
      borderColor = widget.defaultBorderColor;
    }

    if (widget.pinBoxDecoration != null) {
      boxDecoration = widget.pinBoxDecoration(borderColor);
    } else {
      boxDecoration =
          ProvidedPinBoxDecoration.defaultPinBoxDecoration(borderColor);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        key: ValueKey<String>("container$i"),
        child: Center(child: _animatedTextBox(strList[i], i)),
        decoration: boxDecoration,
        width: widget.pinBoxWidth,
        height: widget.pinBoxHeight,
      ),
    );
  }

  Widget _animatedTextBox(String text, int i) {
    if (widget.pinTextAnimatedSwitcherTransition != null) {
      return AnimatedSwitcher(
        duration: widget.pinTextAnimatedSwitcherDuration,
        transitionBuilder: widget.pinTextAnimatedSwitcherTransition ??
            (Widget child, Animation<double> animation) {
              return child;
            },
        child: Text(
          text,
          key: ValueKey<String>("$text$i"),
          style: widget.pinTextStyle,
        ),
      );
    } else {
      return Text(
        text,
        key: ValueKey<String>("${strList[i]}$i"),
        style: widget.pinTextStyle,
      );
    }
  }
}
