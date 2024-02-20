// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/components/button.dart';
import 'package:store_app/components/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailTextController.text.trim(),
        );
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "User not found");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        return Future.error(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Text(
                  "Enter your password and we will send you a password reset link:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              MyTextField(
                action: TextInputAction.next,
                controller: emailTextController,
                hintText: "Email",
                icon: Icon(Icons.email),
                obscureText: false,
                onSaved: (value) {
                  emailTextController.text = value!;
                  return null;
                },
                validator: (value) {
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (value!.isEmpty) {
                    return ("Enter your email");
                  }
                  if (!emailRegex.hasMatch(value)) {
                    return ("Email has bad format");
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 40, 50),
                child: MyButton(
                  onTap: passwordReset,
                  text: "Reset password",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
