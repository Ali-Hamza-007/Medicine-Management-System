import 'package:flutter/material.dart';
//import 'package:pharmacy_management_system_flutter/EditMedicinePage.dart';

import 'EditSupplierPage.dart';

class editSupplierDialgue extends StatefulWidget {
  editSupplierDialgue({super.key});

  @override
  State<editSupplierDialgue> createState() => _editSupplierDialgueState();
}

class _editSupplierDialgueState extends State<editSupplierDialgue> {
  String companyName = '';

  final TextEditingController _companyNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _companyNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Supplier Dialogue'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(
                label: Text('Enter Company Name '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(200, 5)),
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
              ),
              onPressed: () {
                companyName = _companyNameController.text.trim();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditSupplierPage(companyName: companyName);
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
