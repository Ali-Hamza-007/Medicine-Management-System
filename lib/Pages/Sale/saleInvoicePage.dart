import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaleInvoicePage extends StatefulWidget {
  const SaleInvoicePage({super.key});

  @override
  State<SaleInvoicePage> createState() => _SaleInvoicePageState();
}

class _SaleInvoicePageState extends State<SaleInvoicePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _potencyController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String name = '';
  String potency = '';
  String quantity = '';
  String availableQuantity = '';
  String price = '';
  String totalPrice = '';

  Future<bool> isMedFound({
    required String name,
    required String potency,
  }) async {
    final result =
        await FirebaseFirestore.instance
            .collection('Medicine')
            .where('medName', isEqualTo: name)
            .where('potency', isEqualTo: potency)
            .get();

    if (result.docs.isNotEmpty) {
      final data = result.docs.first;
      this.name = data['medName'];
      this.potency = data['potency'];
      price = data['pricePerUnit'];
      availableQuantity = data['quantity'];

      return true;
    }
    return false;
  }

  Future<void> updateMedData({
    required String name,
    required String potency,
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
        'quantity': availableQuantity,
      });
    }
  }

  Future<void> uploadSaleData() async {
    await FirebaseFirestore.instance.collection('Sale').add({
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

    final found = await isMedFound(name: name, potency: potency);
    if (found) {
      final double inputQty = double.tryParse(quantity) ?? 0;
      final double stockQty = double.tryParse(availableQuantity) ?? 0;
      final double unitPrice = double.tryParse(price) ?? 0;

      if (inputQty <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Enter a valid quantity',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        return;
      }

      if (inputQty <= stockQty) {
        totalPrice = (inputQty * unitPrice).toStringAsFixed(0);
        availableQuantity = (stockQty - inputQty).toStringAsFixed(0);

        await uploadSaleData();
        await updateMedData(name: name, potency: potency);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Sale successful!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );

        _nameController.clear();
        _potencyController.clear();
        _quantityController.clear();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Only $availableQuantity units available',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Medicine not found!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _potencyController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Sale Medicine'), centerTitle: true),
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
                child: Text('Buy', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
