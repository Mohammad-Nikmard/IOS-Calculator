import 'package:flutter/material.dart';
import 'package:ios_calculator/constants/constants.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

String inputuser = "";
String result = "";

class _CalculatorScreenState extends State<CalculatorScreen> {
  void calculate(String text) {
    setState(() {
      inputuser = inputuser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: SizedBox(
                        height: 35,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Text(
                                inputuser,
                                style: TextStyle(
                                  color: CalulatorColors.textcolor2,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        result,
                        style: TextStyle(
                          color: CalulatorColors.textcolor2,
                          fontSize: 75,
                          fontWeight: FontWeight.w100,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _getbuttons("AC", "+/-", "%", "/"),
                      _getbuttons("7", "8", "9", "*"),
                      _getbuttons("4", "5", "6", "-"),
                      _getbuttons("1", "2", "3", "+"),
                      _getbuttons2("0", ".", "="),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getbuttons(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text1),
          ),
          onPressed: () {
            if (text1 == "AC") {
              setState(() {
                inputuser = "";
                result = "";
              });
            } else {
              calculate(text1);
            }
          },
          child: Center(
            child: Text(
              text1,
              style: TextStyle(
                color: textcolor(text1),
                fontSize: 30,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text2),
          ),
          onPressed: () {
            if (text2 == "+/-") {
              if (inputuser.length > 0) {
                setState(() {
                  inputuser = inputuser.substring(0, inputuser.length - 1);
                });
              }
            } else {
              calculate(text2);
            }
          },
          child: Center(
            child: Text(
              text2,
              style: TextStyle(
                color: textcolor(text2),
                fontSize: 30,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text3),
          ),
          onPressed: () {
            calculate(text3);
          },
          child: Center(
            child: Text(
              text3,
              style: TextStyle(
                color: textcolor(text3),
                fontSize: 30,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text4),
          ),
          onPressed: () {
            calculate(text4);
          },
          child: Center(
            child: Text(
              text4,
              style: TextStyle(
                color: textcolor(text4),
                fontSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getbuttons2(String text1, String text2, String text3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            calculate(text1);
          },
          child: Container(
            width: 170.0,
            height: 80.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
              child: Text(
                text1,
                style: TextStyle(
                  color: textcolor(text1),
                  fontSize: 30,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85.0),
              color: buttoncolors(text1),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text2),
          ),
          onPressed: () {
            calculate(text2);
          },
          child: Center(
            child: Text(
              text2,
              style: TextStyle(
                color: textcolor(text2),
                fontSize: 30,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(85, 85),
            shape: CircleBorder(),
            backgroundColor: buttoncolors(text3),
          ),
          onPressed: () {
            if (text3 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputuser);
              double eval =
                  expression.evaluate(EvaluationType.REAL, ContextModel());

              setState(() {
                result = eval.toString();
              });
            } else {
              calculate(text3);
            }
          },
          child: Center(
            child: Text(
              text3,
              style: TextStyle(
                color: textcolor(text3),
                fontSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var list = ["AC", "+/-", "%"];

    for (var element in list) {
      if (text == element) {
        return true;
      }
    }
    return false;
  }

  bool isOperator2(String text) {
    var list = ["=", "+", "-", "*", "/"];

    for (var element in list) {
      if (text == element) {
        return true;
      }
    }
    return false;
  }

  Color buttoncolors(String text) {
    if (isOperator(text)) {
      return CalulatorColors.buttoncolor2;
    } else if (this.isOperator2(text)) {
      return CalulatorColors.buttoncolor3;
    } else {
      return CalulatorColors.buttonColor1;
    }
  }

  Color textcolor(String text) {
    if (this.isOperator(text)) {
      return CalulatorColors.textcolor1;
    } else {
      return CalulatorColors.textcolor2;
    }
  }
}
