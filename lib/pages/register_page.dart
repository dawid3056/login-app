// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:store_app/components/button.dart';
import 'package:store_app/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  
  final Function() onTap;
  
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.lock,
                  size: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Text("Let's create an account!"),
              ),
              MyTextField(
                controller: emailcTextController,
                hintText: "Enter your email",
                icon: Icon(Icons.email),
                obscureText: false,
              ),
              MyTextField(
                controller: passwordTextController,
                hintText: "Enter your password",
                icon: Icon(Icons.key),
                obscureText: true,
              ),
              MyTextField(
                controller: confirmPasswordTextController,
                hintText: "Confirm your password",
                icon: Icon(Icons.key),
                obscureText: true,
              ),
              MyButton(
                onTap: () {},
                text: "Sign Up",
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
