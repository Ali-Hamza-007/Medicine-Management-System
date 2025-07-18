import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteMedicinePage extends StatefulWidget {
  const DeleteMedicinePage({super.key});

  @override
  State<DeleteMedicinePage> createState() => _DeleteMedicinePageState();
}

class _DeleteMedicinePageState extends State<DeleteMedicinePage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _potencyController = TextEditingController();

  String name = '';

  String userId = '';

  String potency = '';

  Future<void> deleteMed({
    required String medicineName,
    required String medicinePotency,
  }) async {
    final result =
        await FirebaseFirestore.instance
            .collection('Medicine')
            .where('medName', isEqualTo: medicineName)
            .where('potency', isEqualTo: medicinePotency)
            .get();

    if (result.docs.isNotEmpty) {
      var doc = result.docs.first;
      userId = doc.id;
      await FirebaseFirestore.instance
          .collection('Medicine')
          .doc(userId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Delete Medicine'), centerTitle: true),
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
              SizedBox(height: 10),

              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(200, 5)),

                  backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                ),
                onPressed: () {
                  name = _nameController.text.trim();

                  potency = _potencyController.text.trim();

                  deleteMed(medicineName: name, medicinePotency: potency);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleted Successfully !',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
