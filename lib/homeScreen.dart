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
final textControllerDisplay = TextEditingController();
bool eval = false;
double _panelHeightOpen = 220.0;
double _panelHeightClosed = 20.0;
bool isEmpty = true;
bool hasoperator = false;
bool isAdvVisible = true;
var whatOperator = new List<String>();
int operatorIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
    textControllerDisplay.addListener(() {});
  }

  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    textControllerDisplay.dispose();
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
                height: (0.45) * MediaQuery.of(context).size.height,
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
                          divide('÷'),
                          SizedBox(
                            height: 10,
                          ),
                          multiply('×'),
                          SizedBox(
                            height: 10,
                          ),
                          subtract('-'),
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
            ),
            SlidingUpPanel(
              panel: Display(
                input: textControllerDisplay,
                result: textControllerResult,
                arrowDirection: isAdvVisible,
              ),
              minHeight: (0.55) * MediaQuery.of(context).size.height,
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
              onPanelOpened: () {
                setState(() {
                  isAdvVisible = false;
                });
              },
              onPanelClosed: () {
                setState(() {
                  isAdvVisible = true;
                });
              },
            ),
            isAdvVisible
                ? Positioned(
                    top: (0.55) * MediaQuery.of(context).size.height -
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
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  Widget numpad(btntext) {
    return Container(
      height: (0.09) * MediaQuery.of(context).size.height,
      width: (0.22) * MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w400,
              color: Color(0xFF121212)),
        ),
        onPressed: () {
          if (eval == true) {
            textControllerDisplay.text = '';
            eval = false;
          }
          setState(() {
            textControllerDisplay.text = textControllerDisplay.text + btntext;
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
      height: (0.07) * MediaQuery.of(context).size.height,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              color: Color(0xff5486fb),
              fontSize: 35,
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          setState(() {
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + btntext;
            hasoperator = true;
            whatOperator.add(btntext);
            operatorIndex++;
          });
        },
      ),
    );
  }

  Widget subtract(btntext) {
    return Container(
      height: (0.07) * MediaQuery.of(context).size.height,
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              color: Color(0xff5486fb),
              fontSize: 60,
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          setState(() {
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + btntext;
            hasoperator = true;
            whatOperator.add(btntext);
            operatorIndex++;
          });
        },
      ),
    );
  }

  Widget multiply(btntext) {
    return Container(
      height: (0.07) * MediaQuery.of(context).size.height,
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + "*";
            hasoperator = true;
            whatOperator.add(btntext);
            operatorIndex++;
          });
        },
      ),
    );
  }

  Widget divide(btntext) {
    return Container(
      height: (0.07) * MediaQuery.of(context).size.height,
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + "/";
            hasoperator = true;
            whatOperator.add(btntext);
            operatorIndex++;
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
        color: Colors.white,
        onPressed: () {
          setState(() {
            textControllerDisplay.text = (textControllerDisplay.text
                .substring(0, textControllerDisplay.text.length - 1));
            textControllerInput.text = (textControllerInput.text
                .substring(0, textControllerInput.text.length - 1));
          });
            if (textControllerDisplay.text
                    .split(whatOperator[operatorIndex - 1])[1]
                    .length ==
                0) {
              result(textControllerInput.text
                  .substring(0, textControllerInput.text.length - 1));
              operatorIndex--;
            } else {
              result(textControllerInput.text);
            }
          if (textControllerDisplay.text.split(whatOperator[0])[1].length ==
              0) {
            textControllerResult.text = '';
          }
        },
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
            textControllerDisplay.text = "";
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
          setState(() {
            textControllerDisplay.text = textControllerResult.text;
            textControllerResult.text = ' ';
            textControllerInput.text = ' ';
            eval = true;
            hasoperator = false;
            operatorIndex = 0;
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
            log('log'),
            advanced('!'),
            advanced('^')
          ],
        ),
        Row(
          children: <Widget>[
            advanced('π'),
            exp('e'),
            advanced('('),
            advanced(')'),
            sqrt('√')
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + btntext;
            hasoperator = true;
          });
        },
      ),
    );
  }

  Widget sqrt(btntext) {
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + "sqrt";
            hasoperator = true;
          });
        },
      ),
    );
  }

  Widget log(btntext) {
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + "10log";
            hasoperator = true;
          });
        },
      ),
    );
  }

  Widget exp(btntext) {
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
            textControllerDisplay.text = textControllerDisplay.text + btntext;
            textControllerInput.text = textControllerInput.text + "e";
            hasoperator = true;
            result("e1");
          });
        },
      ),
    );
  }

  result(input) {
    if (hasoperator) {
      Parser p = new Parser();
      ContextModel cm = new ContextModel();
      Expression exp = p.parse(input);
      int precision;
      if (exp.evaluate(EvaluationType.REAL, cm).toString().length > 10) {
        precision =
            exp.evaluate(EvaluationType.REAL, cm).toString().length - 10;
        setState(() {
          textControllerResult.text = exp
              .evaluate(EvaluationType.REAL, cm)
              .toString()
              .substring(
                  0,
                  exp.evaluate(EvaluationType.REAL, cm).toString().length -
                      precision);
        });
      } else {
        setState(() {
          textControllerResult.text =
              exp.evaluate(EvaluationType.REAL, cm).toString();
        });
      }
    } else {
      textControllerResult.text = "";
    }
  }
}
