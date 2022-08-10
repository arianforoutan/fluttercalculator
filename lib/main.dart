import 'package:flutter/material.dart';
import 'package:flutter_application_calculator/constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(Calculatorapplication());
}

class Calculatorapplication extends StatefulWidget {
  Calculatorapplication({Key? key}) : super(key: key);

  @override
  State<Calculatorapplication> createState() => _CalculatorapplicationState();
}

class _CalculatorapplicationState extends State<Calculatorapplication> {
  var inputUser = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text1),
          ),
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(color: getTextColor(text1), fontSize: 26),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'C') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(color: getTextColor(text2), fontSize: 26),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(color: getTextColor(text3), fontSize: 26),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, ContextModel());

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(color: getTextColor(text4), fontSize: 26),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: textGreen, fontSize: 42.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('(', ')', '^', '!'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('AC', 'C', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('6', '5', '4', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('0', '00', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    final List = ['AC', 'C', '%', '/', '*', '-', '+', '=', '(', ')', '!', '^'];

    for (var element in List) {
      if (text == element) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
