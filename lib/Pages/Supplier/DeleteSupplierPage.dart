import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteSupplierPage extends StatefulWidget {
  const DeleteSupplierPage({super.key});

  @override
  State<DeleteSupplierPage> createState() => _DeleteSupplierPageState();
}

class _DeleteSupplierPageState extends State<DeleteSupplierPage> {
  final TextEditingController _companyNameController = TextEditingController();

  String companyName = '';

  String userId = '';

  Future<void> deleteSupplier({required String companyName}) async {
    final result =
        await FirebaseFirestore.instance
            .collection('Supplier')
            .where('companyName', isEqualTo: companyName)
            .get();

    if (result.docs.isNotEmpty) {
      var doc = result.docs.first;
      userId = doc.id;
      await FirebaseFirestore.instance
          .collection('Supplier')
          .doc(userId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Delete Supplier'), centerTitle: true),
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

                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () {
                  companyName = _companyNameController.text.trim();

                  deleteSupplier(companyName: companyName);
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
                child: Text('Delete ', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
