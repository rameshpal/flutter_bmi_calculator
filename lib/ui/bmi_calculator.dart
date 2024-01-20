import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<StatefulWidget> createState() {
    return BmiCalculatorState();
  }
}

class BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _etAgeController = TextEditingController();
  final TextEditingController _etHeightController = TextEditingController();
  final TextEditingController _etWeightController = TextEditingController();
  double centimeter = 0.0;
  double result = 0.0;
  String _resultReading = "";
  String _finalResult = "";


// https://www.epic4health.com/bmiformula.html
// BMI Categories:
// Underweight = <18.5
// Normal weight = 18.5–24.9
// Overweight = 25–29.9

  void _calculateBMI() {
    setState(() {
      int age = int.parse(_etAgeController.text);
      double height = double.parse(_etHeightController.text);
      centimeter = height;
      double weight = double.parse(_etWeightController.text);

      if ((_etAgeController.text.isNotEmpty || age > 0) &&
          (_etHeightController.text.isNotEmpty || centimeter > 0) &&
          (_etWeightController.text.isNotEmpty || weight > 0)) {
        result = weight / (centimeter * centimeter) * 10000;

        if (double.parse(result.toStringAsFixed(1)) < 18.5) {
          _resultReading = "Underweight";
          // print(_resultReading);
        } else if (double.parse(result.toStringAsFixed(1)) >= 18.5 &&
            result < 25.0) {
          _resultReading = "Great Shape!";
        } else if (double.parse(result.toStringAsFixed(1)) >= 25.0 &&
            result < 30) {
          _resultReading = "Overweight";
        } else if (double.parse(result.toStringAsFixed(1)) >= 30.0) {
          _resultReading = "Obese";
        } else {
          result = 0.0;
        }
      }
    });

    _finalResult = "Your BMI: ${result.toStringAsFixed(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "BMI",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Image.asset('lib/images/bmi.png'),
            const SizedBox(
              height: 3,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey.shade200,
              child: Column(children: [
                TextField(
                  controller: _etAgeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline),
                      hintText: 'eg. 25',
                      labelText: 'Age'),
                ),
                TextField(
                  controller: _etHeightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.insert_chart),
                      hintText: 'eg. 6',
                      labelText: 'Height in Centimeters'),
                ),
                TextField(
                  controller: _etWeightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.line_weight),
                      hintText: 'eg. 25',
                      labelText: 'Weight in Kg'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: _calculateBMI,
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _finalResult,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(_resultReading,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
