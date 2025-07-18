import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_management_system_flutter/Pages/HomePage.dart';

class EditMedicinePage extends StatefulWidget {
  final String Name;
  final String Potency;

  EditMedicinePage({super.key, required this.Name, required this.Potency});

  @override
  State<EditMedicinePage> createState() => _EditMedicinePageState();
}

class _EditMedicinePageState extends State<EditMedicinePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _potencyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String name = '';
  String userId = '';
  String companyName = '';
  String potency = '';
  String quantity = '';
  String price = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await editMed(medicineName: widget.Name, medicinePotency: widget.Potency);
      _nameController.text = name;
      _companyNameController.text = companyName;
      _potencyController.text = potency;
      _quantityController.text = quantity;
      _priceController.text = price;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyNameController.dispose();
    _potencyController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> uploadEditedMedicineData() async {
    await FirebaseFirestore.instance.collection('Medicine').doc(userId).update({
      'medName': name,
      'manufacturer': companyName,
      'potency': potency,
      'pricePerUnit': price,
      'quantity': quantity,
    });
  }

  Future<void> editMed({
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

      name = doc['medName'];
      companyName = doc['manufacturer'];
      potency = doc['potency'];
      quantity = doc['quantity'];
      price = doc['pricePerUnit'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No Medicine Found!',
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
        appBar: AppBar(title: Text('Edit Medicine'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  hintText: name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  labelText: 'Manufacturer',
                  hintText: companyName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _potencyController,
                decoration: InputDecoration(
                  labelText: 'Potency',
                  hintText: potency,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: quantity,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price Per Unit',
                  hintText: price,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(200, 50)),
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.lightBlueAccent,
                  ),
                ),
                onPressed: () async {
                  name =
                      _nameController.text.trim().isEmpty
                          ? name
                          : _nameController.text.trim();
                  companyName =
                      _companyNameController.text.trim().isEmpty
                          ? companyName
                          : _companyNameController.text.trim();
                  potency =
                      _potencyController.text.trim().isEmpty
                          ? potency
                          : _potencyController.text.trim();
                  quantity =
                      _quantityController.text.trim().isEmpty
                          ? quantity
                          : _quantityController.text.trim();
                  price =
                      _priceController.text.trim().isEmpty
                          ? price
                          : _priceController.text.trim();

                  await uploadEditedMedicineData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Edited Successfully !',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
