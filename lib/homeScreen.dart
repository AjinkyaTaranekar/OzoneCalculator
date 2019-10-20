import 'package:calculator/display.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String strInput = "";
final textControllerInput = TextEditingController();
final textControllerResult = TextEditingController();
bool eval = false;
double _panelHeightOpen = 220.0;
double _panelHeightClosed = 20.0;
bool isEmpty = true;
bool hasoperator = false;
bool isAdvVisible = true;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }

  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: (0.5) * MediaQuery.of(context).size.height,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: (0.8) * MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              numpad('7'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('8'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('9')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              numpad('4'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('5'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('6'),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              numpad('1'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('2'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('3'),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              numpad('.'),
                              SizedBox(
                                width: 10,
                              ),
                              numpad('0'),
                              SizedBox(
                                width: 10,
                              ),
                              eval == true ? clear('C') : backspace()
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: (0.20) * MediaQuery.of(context).size.width,
                      color: Color(0xfff2f4ff),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          operator('/'),
                          SizedBox(
                            height: 10,
                          ),
                          operator('*'),
                          SizedBox(
                            height: 10,
                          ),
                          operator('-'),
                          SizedBox(
                            height: 10,
                          ),
                          operator('+'),
                          SizedBox(
                            height: 10,
                          ),
                          evaluate('=')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ), SlidingUpPanel(
                panel: Display(
                    input: textControllerInput, result: textControllerResult, arrowDirection: isAdvVisible,),
                minHeight: (0.5) * MediaQuery.of(context).size.height,
                maxHeight: MediaQuery.of(context).size.height,
                backdropEnabled: true,
                parallaxOffset: .5,
                slideDirection: SlideDirection.DOWN,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 0.0,
                    color: Color.fromRGBO(0, 0, 0, 0),
                  )
                ],
                onPanelOpened: (){
                  setState(() {
                   isAdvVisible = false; 
                  });
                },
                onPanelClosed: (){
                  setState(() {
                   isAdvVisible = true; 
                  });
                },
              ),
            isAdvVisible ? Positioned(
                top: (0.5) * MediaQuery.of(context).size.height -
                    _panelHeightOpen,
                child: Container(
                  height: _panelHeightOpen,
                  width: MediaQuery.of(context).size.width,
                  child: SlidingUpPanel(
                    maxHeight: _panelHeightOpen,
                    minHeight: _panelHeightClosed,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    panel: advPanel(),
                    color: Color(0xff5283f6),
                    backdropEnabled: false,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 0.0,
                        color: Color.fromRGBO(0, 0, 0, 0),
                      )
                    ],
                  ),
                )) : Container()
          ],
        ),
      ),
    );
  }

  Widget numpad(btntext) {
    return Container(
      height: (0.11) * MediaQuery.of(context).size.height,
      width: (0.22) * MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = textControllerInput.text + btntext;
          });
          result(textControllerInput.text);
        },
        color: Colors.white,
      ),
    );
  }

  Widget operator(btntext) {
    return Container(
      height: (0.08) * MediaQuery.of(context).size.height,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              color: Color(0xff5486fb),
              fontSize: 40,
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = textControllerInput.text + btntext;
            hasoperator = true;
          });
        },
      ),
    );
  }

  Widget backspace() {
    return Container(
      height: (0.11) * MediaQuery.of(context).size.height,
      width: (0.22) * MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Icon(Icons.backspace, size: 30, color: Colors.red),
        onPressed: () {
          textControllerInput.text = (textControllerInput.text.length > 0)
              ? (textControllerInput.text
                  .substring(0, textControllerInput.text.length - 1))
              : "";
        },
        color: Colors.white,
      ),
    );
  }

  Widget clear(btntext) {
    return Container(
      height: (0.11) * MediaQuery.of(context).size.height,
      width: (0.22) * MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(fontSize: 40),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = "";
            textControllerResult.text = "";
            eval = false;
          });
        },
        color: Colors.white,
      ),
    );
  }

  Widget evaluate(btntext) {
    return Container(
      height: (0.08) * MediaQuery.of(context).size.height,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              color: Color(0xff5486fb),
              fontSize: 40,
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          Parser p = new Parser();
          ContextModel cm = new ContextModel();
          Expression exp = p.parse(textControllerInput.text);
          setState(() {
            textControllerInput.text =
                exp.evaluate(EvaluationType.REAL, cm).toString();
            textControllerResult.text = ' ';
            eval = true;
          });
        },
      ),
    );
  }

  Widget advPanel() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            advanced('INV'),
            advanced('DEG'),
            advanced('sin'),
            advanced('cos'),
            advanced('tan')
          ],
        ),
        Row(
          children: <Widget>[
            advanced('%'),
            advanced('ln'),
            advanced('log'),
            advanced('!'),
            advanced('^')
          ],
        ),
        Row(
          children: <Widget>[
            advanced('π'),
            advanced('e'),
            advanced('('),
            advanced(')'),
            advanced('√')
          ],
        )
      ],
    );
  }

  Widget advanced(btntext) {
    return Container(
      height: (0.08) * MediaQuery.of(context).size.height,
      width: (0.20) * MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = textControllerInput.text + btntext;
            hasoperator = true;
          });
        },
      ),
    );
  }

  result(input) {
    Parser p = new Parser();
    ContextModel cm = new ContextModel();
    Expression exp = p.parse(input);
    setState(() {
      textControllerResult.text =
          exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }
}
