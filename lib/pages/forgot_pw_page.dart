// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:store_app/components/button.dart';
import 'package:store_app/components/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
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
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                onTap: () {},
                text: "Reset password",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
