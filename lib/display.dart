import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  final input;
  final result;
  final arrowDirection;
  Display({@required this.input, this.result, this.arrowDirection});

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: (0.63) * MediaQuery.of(context).size.height,
          ),
          Container(
            height: (0.20) * MediaQuery.of(context).size.height,
            child: TextField(
              decoration: new InputDecoration.collapsed(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                  )),
              style: TextStyle(
                fontSize: 60,
                fontFamily: 'RobotoMono',
              ),
              textAlign: TextAlign.right,
              controller: widget.input,
              focusNode: AlwaysDisabledFocusNode(),
            ),
          ),
          Container(
              height: (0.1) * MediaQuery.of(context).size.height,
              child: TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "",
                    hintStyle: TextStyle(fontFamily: 'RobotoMono')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 32, fontFamily: 'RobotoMono', color: Colors.grey),
                textAlign: TextAlign.right,
                controller: widget.result,
                focusNode: AlwaysDisabledFocusNode(),
              )),
          Container(
            height: (0.05) * MediaQuery.of(context).size.height,
            child: Icon(
              widget.arrowDirection ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up
            ),
          ),
        ],
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
