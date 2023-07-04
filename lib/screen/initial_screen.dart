import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff040e15),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.10,
              child: resultWidget(),
            ),
            Expanded(child: customButton())
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Container(
      color: const Color(0xFF1d2630),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(66, 233, 232, 232),
      child: GridView.builder(
        itemCount: buttonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return button(buttonList[index]);
        },
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "(" ||
        text == ")" ||
        text == "C") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBGColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }

    if (text == "=") {
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return const Color(0xFF1d2630);
  }

  Widget button(String text) {
    return InkWell(
      onTap: (){
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBGColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ]
        ),
        child: Center(
          child: Text(text, style: TextStyle(
            color: getColor(text),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      userInput = result;

      if (result.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }

  String calculate(){
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
