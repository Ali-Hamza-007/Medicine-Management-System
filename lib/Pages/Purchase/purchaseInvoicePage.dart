import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurchaseInvoicePage extends StatefulWidget {
  const PurchaseInvoicePage({super.key});

  @override
  State<PurchaseInvoicePage> createState() => _PurchaseInvoicePageState();
}

class _PurchaseInvoicePageState extends State<PurchaseInvoicePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _potencyController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String name = '';
  String manufacturer = '';

  String potency = '';
  String quantity = '';
  String availableQuantity = '';
  String price = '';
  String totalPrice = '';

  Future<void> updateMedData({
    required String name,
    required String potency,
    required String manufacturer,
  }) async {
    final result =
        await FirebaseFirestore.instance
            .collection('Medicine')
            .where('medName', isEqualTo: name)
            .where('potency', isEqualTo: potency)
            .get();

    if (result.docs.isNotEmpty) {
      final id = result.docs.first.id;
      await FirebaseFirestore.instance.collection('Medicine').doc(id).update({
        'pricePerUnit': price,
        'quantity': availableQuantity,
      });
    } else {
      await FirebaseFirestore.instance.collection('Medicine').doc().set({
        'medName': name,
        'potency': potency,
        'manufacturer': manufacturer,
        'quantity': availableQuantity,
        'pricePerUnit': price,
      });
    }
  }

  Future<void> uploadPurchaseData() async {
    await FirebaseFirestore.instance.collection('Purchase').add({
      'medName': name,
      'potency': potency,
      'pricePerUnit': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'dateTime': DateTime.now().toString(),
    });
  }

  void handleBuy() async {
    name = _nameController.text.trim();
    potency = _potencyController.text.trim();
    quantity = _quantityController.text.trim();
    manufacturer = _manufacturerController.text.trim();
    price = _priceController.text.trim();

    if (name.isEmpty || potency.isEmpty || quantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please fill in all fields',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    final double inputQty = double.tryParse(quantity) ?? 0;
    final double stockQty = double.tryParse(availableQuantity) ?? 0;
    final double unitPrice = double.tryParse(price) ?? 0;

    totalPrice = (inputQty * unitPrice).toStringAsFixed(0);
    availableQuantity = (stockQty + inputQty).toStringAsFixed(0);

    await uploadPurchaseData();
    await updateMedData(
      name: name,
      potency: potency,
      manufacturer: manufacturer,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Purchase successful!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    _nameController.clear();
    _potencyController.clear();
    _quantityController.clear();
    _priceController.clear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _potencyController.dispose();
    _quantityController.dispose();
    _manufacturerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Purchase Medicine'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text('Enter Medicine Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _manufacturerController,
                decoration: InputDecoration(
                  label: Text('Enter Manufacturer Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  label: Text('Enter PricePerUnit'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              TextField(
                controller: _potencyController,
                decoration: InputDecoration(
                  label: Text('Enter Medicine Potency'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  label: Text('Enter Quantity'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleBuy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(200, 45),
                ),
                child: Text('Purchase', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
