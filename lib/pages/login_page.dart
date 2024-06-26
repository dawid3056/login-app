import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:store_app/components/button.dart';
import 'package:store_app/components/password_text_field.dart';
import 'package:store_app/components/square_tile.dart';
import 'package:store_app/components/text_field.dart';
import 'package:store_app/pages/forgot_pw_page.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obsecureText = true;

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                });
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
            Fluttertoast.showToast(msg: "Incorrect email or password");
          } else {
            Fluttertoast.showToast(
                msg: "Some error occured. Please try again later.");
          }
        } else {
          Fluttertoast.showToast(msg: e.toString());
          return Future.error(e);
        }
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential fbAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(fbAuthCredential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                    child: Icon(
                      Icons.lock,
                      size: 100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Text("Welcome back!"),
                  ),
                  MyTextField(
                    action: TextInputAction.next,
                    controller: emailTextController,
                    hintText: "Email",
                    icon: const Icon(Icons.email),
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
                  PasswordTextField(
                    action: TextInputAction.done,
                    controller: passwordTextController,
                    hintText: "Password",
                    icon: const Icon(Icons.key),
                    obscureText: _obsecureText,
                    iconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText = !_obsecureText;
                        });
                      },
                      icon: _obsecureText
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    onTap: () {
                      signIn(emailTextController.text,
                          passwordTextController.text);
                    },
                    text: "Sign In",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: signInWithGoogle,
                        child: const SquareTail(
                          imagePath: 'assets/images/google_image.png',
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: signInWithFacebook,
                        child: const SquareTail(
                          imagePath: 'assets/images/fb_image.png',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()));
                          },
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
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
