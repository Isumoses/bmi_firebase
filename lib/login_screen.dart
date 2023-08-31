import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class loginScreen extends StatelessWidget {
  loginScreen({super.key}); 

  //contoller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//variables
  // ignore: prefer_typing_uninitialized_variables
  late final emailAddress;
  // ignore: prefer_typing_uninitialized_variables
  late final password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Email Address: "),
              //email
              TextFormField(
                controller: emailController,
                onSaved: (Value) {
                  emailAddress = Value;
                },
              ),
              //password
              const Text("Password: "),
              TextFormField(
                controller: passwordController,
                onSaved: (Value) {
                  password = Value;
                },
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    print(emailAddress);
                    print(password);
                  }
                },
                child: const Text("login"),
              )
            ],
          ),
        ));
  }
}
