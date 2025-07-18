import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewMedicineStockPage extends StatefulWidget {
  const ViewMedicineStockPage({super.key});

  @override
  State<ViewMedicineStockPage> createState() => _ViewMedicineStockPageState();
}

class _ViewMedicineStockPageState extends State<ViewMedicineStockPage> {
  List loadedData = [];
  String name = '';

  String companyName = '';
  String potency = '';
  String quantity = '';
  String price = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final result =
          await FirebaseFirestore.instance.collection('Medicine').get();

      if (result.docs.isNotEmpty) {
        setState(() {
          loadedData = result.docs.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('View Medicine Stock'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'MedName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'Potency',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'Manufacturer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'PricePerUnit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: loadedData.length,
                  itemBuilder: (context, index) {
                    name = loadedData[index]['medName'];
                    companyName = loadedData[index]['manufacturer'];
                    potency = loadedData[index]['potency'];
                    price = loadedData[index]['pricePerUnit'];
                    quantity = loadedData[index]['quantity'];
                    return Card(
                      child: Row(
                        children: [
                          Expanded(child: Text(name)),

                          Expanded(child: Text(potency)),

                          Expanded(child: Text(companyName)),

                          Expanded(child: Text(quantity)),

                          Expanded(child: Text(price)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
