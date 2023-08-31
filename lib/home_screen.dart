import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double _value = 100;
  //TextEditingController heightController = TextEditingController();

  String gender = 'Male';
  DateTime selectedDate = DateTime.now();

  int age = 0;
  double bmi = 0.0;
  String bmiComment = '';
  int genderVal = 0;
  void refreshForm() {
    setState(() {
      // Clear the form fields and reset variables
      nameController.clear();
      addressController.clear();
      weightController.clear();
      _value = 100;
      //heightController.clear();
      gender = 'Male';
      selectedDate = DateTime.now();
      age = 0;
      bmi = 0.0;
      bmiComment = '';
    });
  }

  void calculateAge() {
    final currentDate = DateTime.now();
    age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
  }

  void calculateBMI() {
    double height = (_value);
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (weight != null && height != null && height > 0) {
      bmi = weight / ((height / 100) * (height / 100));
      if (bmi < 18.5) {
        bmiComment = 'You are Underweight';
      } else if (bmi < 25) {
        bmiComment = 'You are Normal weight';
      } else if (bmi < 30) {
        bmiComment = 'You are Overweight';
      } else {
        bmiComment = 'You are Obese';
      }
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      double height = _value;
      double weight = double.tryParse(weightController.text) ?? 0.0;

      if (weight > 200 || height > 250) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Measurements'),
              content: Text('Please enter valid weight and height.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      calculateAge();
      calculateBMI();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            title: Center(
                child: Text(
              'BMI INFORMATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.pink,
                    ),
                    child:
                        Text(' Name: ${nameController.text}', style: bmiText)),
                Container(
                  width: double.maxFinite,
                  height: containerHeight,
                  color: Colors.pinkAccent,
                  child: Text(' Address: ${addressController.text}',
                      style: bmiText),
                ),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Colors.pink,
                    child: Text(' Gender: $gender', style: bmiText)),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  color: Colors.pinkAccent,
                  child: Text(
                      ' Date of Birth: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                      style: bmiText),
                ),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Colors.pink,
                    child: Text(' Age: $age', style: bmiText)),
                Container(
                  width: double.maxFinite,
                  height: containerHeight,
                  color: Color.fromARGB(255, 92, 30, 228),
                  child: Text(' Weight: ${weightController.text} kg',
                      style: bmiText),
                ),
                Container(
                  width: double.maxFinite,
                  height: containerHeight,
                  color: Color.fromARGB(255, 71, 30, 233),
                  child: Text(' Height: ' + _value.round().toString() + ' cm',
                      style: bmiText),
                ),
                Container(
                  width: double.maxFinite,
                  height: containerHeight,
                  color: Color.fromARGB(255, 93, 64, 255),
                  child:
                      Text(' BMI: ${bmi.toStringAsFixed(2)}', style: bmiText),
                ),
                Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 77, 30, 233),
                    ),
                    child: Text(' Comment: $bmiComment', style: bmiText)),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close', style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI Calculator')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 59,
                        decoration: BoxDecoration(
                            // color: Colors.green,

                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'User Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 82, 42, 226)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(children: [
                  customElevation(),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 66, 37, 231)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ]),
                SizedBox(height: 20),
                Text('Gender',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setState(() {
                        genderVal = 0;
                        gender = 'Male';
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              genderVal == 0 ? Colors.grey : Colors.transparent,
                        ),
                        height: 56,
                        width: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Icon(FontAwesomeIcons.male), Text('Male')],
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => setState(() {
                        genderVal = 1;
                        gender = 'Female';
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              genderVal == 1 ? Colors.grey : Colors.transparent,
                        ),
                        height: 56,
                        width: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.female,
                              color: Color.fromARGB(255, 43, 37, 235),
                            ),
                            Text('Female'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today_outlined),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(selectedDate),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(children: [
                  customElevation(),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Weight',
                        hintText: 'Weight (KG)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 238, 116, 156)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Height',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 2, 60, 146),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Slider(
                              min: 0.0,
                              max: 200.0,
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                              child: Text(_value.round().toString() + ' cm'))
                        ],
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                      elevation: 10,
                      shadowColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class customElevation extends StatelessWidget {
  const customElevation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 59,
        decoration: BoxDecoration(
            // color: Colors.green,

            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

TextStyle bmiText = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
double containerHeight = 30;
