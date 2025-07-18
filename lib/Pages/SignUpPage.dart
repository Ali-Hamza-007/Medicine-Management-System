import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  String? _selectedGender;
  String _name = '';
  String _phoneNo = '';
  String _email = '';
  String _password = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> addUserWithEmailAndPassword() async {
    final userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password);
    User? user = userCredentials.user;
    if (user != null) {
      FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'gender': _selectedGender,
        'uid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                'Sign Up ',
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
              SizedBox(height: 25),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text('Enter Full Name '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items:
                    ["Male", "Female", "Other"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  label: Text('Enter Phone Number '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text('Enter Email Address'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 12),

              TextField(
                obscureText: hidePassword,
                controller: _passwordController,
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
                  label: Text('Enter Confirm Password '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () {
                  _name = _nameController.text.trim();
                  _phoneNo = _phoneController.text.trim();
                  _email = _emailController.text.trim();
                  _password = _passwordController.text.trim();
                  addUserWithEmailAndPassword();
                  Navigator.of(context).pop();
                },
                child: Text('Continue', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
