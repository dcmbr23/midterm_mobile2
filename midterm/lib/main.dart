import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calc(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        // shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator app'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$str',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('C', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('8', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('9', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('x', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('5', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('6', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('-', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('2', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('3', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('+', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    calc('0');
                  },
                  // shape: StadiumBorder(side: BorderSide(width: 0)),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                calcbutton('.', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('=', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  double numberOne = 0;
  double numberTwo = 0;

  dynamic str = '0';

  dynamic res = '';
  dynamic totalRes = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calc(btnText) {
    if (btnText == 'C') {
      str = '0';
      numberOne = 0;
      numberTwo = 0;
      res = '';
      totalRes = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        totalRes = adding();
      } else if (preOpr == '-') {
        totalRes = subtraction();
      } else if (preOpr == 'x') {
        totalRes = multiple();
      } else if (preOpr == '/') {
        totalRes = dividing();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numberOne == 0) {
        numberOne = double.parse(res);
      } else {
        numberTwo = double.parse(res);
      }

      if (opr == '+') {
        totalRes = adding();
      } else if (opr == '-') {
        totalRes = subtraction();
      } else if (opr == 'x') {
        totalRes = multiple();
      } else if (opr == '/') {
        totalRes = dividing();
      }
      preOpr = opr;
      opr = btnText;
      res = '';
    } else if (btnText == '%') {
      res = numberOne / 100;
      totalRes = doesContainDecimal(res);
    } else if (btnText == '.') {
      if (!res.toString().contains('.')) {
        res = res.toString() + '.';
      }
      totalRes = res;
    } else if (btnText == '+/-') {
      res.toString().startsWith('-')
          ? res = res.toString().substring(1)
          : res = '-' + res.toString();
      totalRes = res;
    } else {
      res = res + btnText;
      totalRes = res;
    }

    setState(() {
      str = totalRes;
    });
  }

  String adding() {
    res = (numberOne + numberTwo).toString();
    numberOne = double.parse(res);
    return doesContainDecimal(res);
  }

  String subtraction() {
    res = (numberOne - numberTwo).toString();
    numberOne = double.parse(res);
    return doesContainDecimal(res);
  }

  String multiple() {
    res = (numberOne * numberTwo).toString();
    numberOne = double.parse(res);
    return doesContainDecimal(res);
  }

  String dividing() {
    res = (numberOne / numberTwo).toString();
    numberOne = double.parse(res);
    return doesContainDecimal(res);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
