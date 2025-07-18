import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditSupplierPage extends StatefulWidget {
  final String companyName;
  const EditSupplierPage({super.key, required this.companyName});

  @override
  State<EditSupplierPage> createState() => _EditSupplierPageState();
}

class _EditSupplierPageState extends State<EditSupplierPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _representativeNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String companyName = '';
  String userId = '';
  String representativeName = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await editSupplier(companyName: widget.companyName);

      _companyNameController.text = companyName;
      _representativeNameController.text = representativeName;
      _descriptionController.text = description;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _representativeNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadEditedSupplierData() async {
    await FirebaseFirestore.instance.collection('Supplier').doc(userId).update({
      'companyName': companyName,
      'representativeName': representativeName,
      'description': description,
    });
  }

  Future<void> editSupplier({required String companyName}) async {
    final result =
        await FirebaseFirestore.instance
            .collection('Supplier')
            .where('companyName', isEqualTo: companyName)
            .get();

    if (result.docs.isNotEmpty) {
      var doc = result.docs.first;
      userId = doc.id;

      this.companyName = doc['companyName'];
      representativeName = doc['representativeName'];
      description = doc['description'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No Supplier Found!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Supplier'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  label: Text('Enter New Company Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _representativeNameController,
                decoration: InputDecoration(
                  label: Text('Enter New Representative Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: Text('Enter New Description'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(200, 50),
                ),
                onPressed: () async {
                  companyName = _companyNameController.text.trim();
                  representativeName =
                      _representativeNameController.text.trim();
                  description = _descriptionController.text.trim();

                  await uploadEditedSupplierData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Edited Successfully !',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Edit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
