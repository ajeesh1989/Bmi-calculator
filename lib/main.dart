import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BMIHomePage(),
    );
  }
}

class BMIHomePage extends StatefulWidget {
  const BMIHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMIHomePageState createState() => _BMIHomePageState();
}

final ValueNotifier<double> _bmiResult = ValueNotifier<double>(0.0);

class _BMIHomePageState extends State<BMIHomePage> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  // double? _bmiResult;
  String? _bmiStatus;
  String img =
      'https://assets3.lottiefiles.com/packages/lf20_kOvJ8c/normal/data.json';

  void _calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);
    double bmi = weight / (height * height);
    setState(() {
      _bmiResult.value = bmi;
      if (bmi < 18.5) {
        _bmiStatus = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 25) {
        _bmiStatus = 'Normal';
      } else if (bmi >= 25 && bmi < 30) {
        _bmiStatus = 'Overweight';
      } else if (bmi >= 30 && bmi < 40) {
        _bmiStatus = 'Obese';
      } else {
        _bmiStatus = 'Obesidad Morbida';
      }
    });
    getImage(bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 17, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 17, 30),
        actions: [
          IconButton(
            onPressed: () {
              _bmiResult.value = 0.0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const BMICalculator()),
              );
            },
            icon: const Icon(
              Icons.replay_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: const Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Enter your height',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              TextField(
                style: const TextStyle(color: Colors.white, fontSize: 25),
                controller: _heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Your Height in Cm",
                  hintStyle:
                      const TextStyle(color: Colors.white38, fontSize: 20),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 47, 58, 77),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Enter your weight',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              TextField(
                style: const TextStyle(color: Colors.white, fontSize: 25),
                controller: _weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Your Weight in Kg",
                  hintStyle:
                      const TextStyle(color: Colors.white38, fontSize: 20),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 47, 58, 77),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    _bmiResult != null
                        ? 'BMI: ${_bmiResult.value.toStringAsFixed(1)}'
                        : '',
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      Text(
                        _bmiStatus != null ? 'Status: $_bmiStatus' : '',
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _bmiResult,
                        builder: (context, double value, _) {
                          return _bmiResult.value == 0.0
                              ? const Center(
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    'Need Help?\n\nTo calculate your BMI using height and weight, please enter your height in Cms and weight in Kgs.',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 20),
                                  ),
                                )
                              : Lottie.network(img, fit: BoxFit.cover);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getImage(double bmi) {
    if (bmi < 18.5) {
      setState(() {
        img = 'https://assets7.lottiefiles.com/packages/lf20_tll0j4bb.json';
      });
    } else if (bmi >= 18.5 && bmi < 25) {
      setState(() {
        img =
            'https://assets3.lottiefiles.com/packages/lf20_kOvJ8c/normal/data.json';
      });
    } else if (bmi >= 25 && bmi < 30) {
      setState(() {
        img =
            'https://assets3.lottiefiles.com/packages/lf20_3ejhEJ/over/data.json';
      });
    } else if (bmi >= 30 && bmi < 40) {
      setState(() {
        img =
            'https://assets3.lottiefiles.com/packages/lf20_pOCvY7/obeso/data.json';
      });
    } else {
      setState(() {
        img =
            'https://assets3.lottiefiles.com/packages/lf20_l6lr33/morbid/data.json';
      });
    }
  }
}
