import 'package:flutter/material.dart';
import 'package:store_app/pages/login_page.dart';
import 'package:store_app/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool showloginPage = true;

  void togglePages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginPage) {
      return LoginPage();
    } else {
      return const RegisterPage();
    }
  }
}