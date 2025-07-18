import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _manufacturerController = TextEditingController();

  final TextEditingController _potencyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  String name = '';

  String manufacturer = '';

  String potency = '';
  String price = '';
  String quantity = '';
  Future<void> uploadMedicineData() async {
    await FirebaseFirestore.instance.collection('Medicine').doc().set({
      'medName': name,
      'manufacturer': manufacturer,
      'potency': potency,
      'pricePerUnit': price,
      'quantity': quantity,
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _manufacturerController.dispose();
    _potencyController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Medicine'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _manufacturerController,
                decoration: InputDecoration(
                  label: Text('Enter Medicine Manufacturer Name '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  label: Text('Enter Medicine Quantity '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  label: Text('Enter Medicine Price per unit '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(200, 5)),
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () {
                  name = _nameController.text.trim();
                  manufacturer = _manufacturerController.text.trim();
                  potency = _potencyController.text.trim();
                  quantity = _quantityController.text.trim();
                  price = _priceController.text.trim();
                  uploadMedicineData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added Successfully !',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Future.delayed(Duration(seconds: 4), () {
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
