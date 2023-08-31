import 'package:flutter/material.dart';
//import 'home_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.pink, // Change the primary color
        fontFamily: 'Roboto', // Change the default font family
      ),
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}
