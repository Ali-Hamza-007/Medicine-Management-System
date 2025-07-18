import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool hidePassword = true;
  String userName = '';
  String password = '';
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  Future<void> _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userName,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In ',
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
              SizedBox(height: 32),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  label: Text('Enter username or email '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                obscureText: hidePassword,
                controller: _passController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword == true
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                    ),
                  ),
                  label: Text('Enter password '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () {
                  userName = _userNameController.text.trim();
                  password = _passController.text.trim();
                  _signIn();
                },
                child: Text('Continue', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 18),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'SignUp',
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpPage();
                                  },
                                ),
                              );
                            },
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
