import 'package:flutter/material.dart';
import 'package:pharmacy_management_system_flutter/Pages/Medicine/EditMedicinePage.dart';

class editMedDialgue extends StatefulWidget {
  editMedDialgue({super.key});

  @override
  State<editMedDialgue> createState() => _editMedDialgueState();
}

class _editMedDialgueState extends State<editMedDialgue> {
  String name = '';
  String potency = '';
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _potencyController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _potencyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Medicine Dialogue'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text('Enter Medicine Name '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _potencyController,
              decoration: InputDecoration(
                label: Text('Enter Medicine Potency '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(200, 5)),
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
              ),
              onPressed: () {
                name = _nameController.text.trim();

                potency = _potencyController.text.trim();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditMedicinePage(Name: name, Potency: potency);
                    },
                  ),
                );
              },
              child: Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
