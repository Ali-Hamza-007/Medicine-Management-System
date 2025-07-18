import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSupplierPage extends StatefulWidget {
  const AddSupplierPage({super.key});

  @override
  State<AddSupplierPage> createState() => _AddSupplierPageState();
}

class _AddSupplierPageState extends State<AddSupplierPage> {
  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _representativeNameController =
      TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  String companyName = '';

  String representativeName = '';

  String description = '';
  Future<void> uploadSupplierData() async {
    await FirebaseFirestore.instance.collection('Supplier').doc().set({
      'companyName': companyName,
      'representativeName': representativeName,
      'description': description,
    });
  }

  @override
  void dispose() {
    super.dispose();
    _companyNameController.dispose();
    _representativeNameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Supplier'), centerTitle: true),
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
              TextField(
                controller: _representativeNameController,
                decoration: InputDecoration(
                  label: Text('Enter Representative Name '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: Text('Enter Description '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(200, 5)),

                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () {
                  companyName = _companyNameController.text.trim();

                  representativeName =
                      _representativeNameController.text.trim();
                  description = _descriptionController.text.trim();
                  uploadSupplierData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added Successfully !',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Add ', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
