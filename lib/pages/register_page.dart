// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/components/button.dart';
import 'package:store_app/components/password_text_field.dart';
import 'package:store_app/components/text_field.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  bool _obsecureText1 = true;
  bool _obsecureText2 = true;
  final _formKey = GlobalKey<FormState>();

  void createUser(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then(
              (uid) => {
                Fluttertoast.showToast(msg: "Registration Successful"),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              },
            );
      } catch (e) {
        if (e is FirebaseAuthException) {
          Fluttertoast.showToast(
              msg: "Some error occured. Please try again later.");
        } else {
          Fluttertoast.showToast(msg: e.toString());
          return Future.error(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
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
                    action: TextInputAction.next,
                    controller: emailTextController,
                    hintText: "Enter your email",
                    icon: Icon(Icons.email),
                    obscureText: false,
                    onSaved: (value) {
                      emailTextController.text = value!;
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Enter Your Email");
                      }
                      return null;
                    },
                  ),
                  PasswordTextField(
                    action: TextInputAction.next,
                    controller: passwordTextController,
                    hintText: "Enter your password",
                    icon: Icon(Icons.key),
                    obscureText: _obsecureText1,
                    iconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText1 = !_obsecureText1;
                        });
                      },
                      icon: _obsecureText1
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    onSaved: (value) {
                      passwordTextController.text = value!;
                      return null;
                    },
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }

                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(min. 6 Characters)");
                      }
                      return null;
                    },
                  ),
                  PasswordTextField(
                    action: TextInputAction.done,
                    controller: confirmPasswordTextController,
                    hintText: "Confirm your password",
                    icon: Icon(Icons.key),
                    obscureText: _obsecureText2,
                    iconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText2 = !_obsecureText2;
                        });
                      },
                      icon: _obsecureText2
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    onSaved: (value) {
                      confirmPasswordTextController.text = value!;
                      return null;
                    },
                    validator: (value) {
                      if (confirmPasswordTextController.text !=
                          passwordTextController.text) {
                        return ("Password do not match");
                      }
                      return null;
                    },
                  ),
                  MyButton(
                    onTap: () => createUser(emailTextController.text, passwordTextController.text),
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
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
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
        ),
      ),
    );
  }
}
