import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_management_system_flutter/Pages/SignInPage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  String _phoneNo = '';
  String _gender = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final result =
        await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: user.email)
            .get();
    //print(result.docs.first.data());
    if (result.docs.isNotEmpty) {
      final doc = result.docs.first;

      setState(() {
        _name = doc['name'];
        _phoneNo = doc['phone'];
        _email = doc['email'];
        _gender = doc['gender'];
      });
    }
  }

  Widget info({required String txt, required dynamic icon}) {
    return ListTile(
      leading: icon,
      title: Text(txt),
      tileColor: Color.fromRGBO(227, 227, 227, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Details'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
              maxRadius: 50,
            ),
            SizedBox(height: 20),
            info(txt: _name, icon: Icon(Icons.person_search)),
            SizedBox(height: 3),

            info(txt: _gender, icon: Icon(Icons.person_2_outlined)),
            SizedBox(height: 3),

            info(txt: _phoneNo, icon: Icon(Icons.phone)),
            SizedBox(height: 3),

            info(txt: _email, icon: Icon(Icons.email)),
            SizedBox(height: 3),

            info(txt: '*******', icon: Icon(Icons.password)),

            //  SizedBox(height: 3),
            SizedBox(height: 40),
            //Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
                fixedSize: WidgetStatePropertyAll(Size(200, 5)),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      FirebaseAuth.instance.signOut();
                      return SignInPage();
                    },
                  ),
                );
              },
              child: Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
