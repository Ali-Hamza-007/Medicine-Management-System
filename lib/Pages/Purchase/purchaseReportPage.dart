import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurchaseReportPage extends StatefulWidget {
  const PurchaseReportPage({super.key});

  @override
  State<PurchaseReportPage> createState() => _PurchaseReportPageState();
}

class _PurchaseReportPageState extends State<PurchaseReportPage> {
  List loadedData = [];
  String dateTime = '';
  String name = '';

  String potency = '';
  String quantity = '';
  String price = '';
  String totalPrice = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final result =
          await FirebaseFirestore.instance.collection('Purchase').get();

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
        appBar: AppBar(title: Text('Purchase Report'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date & Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'MedName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    //  Spacer(),
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
                    Expanded(
                      child: Text(
                        'totalPrice',
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
                    dateTime = loadedData[index]['dateTime'];
                    name = loadedData[index]['medName'];
                    totalPrice = loadedData[index]['totalPrice'];
                    potency = loadedData[index]['potency'];
                    price = loadedData[index]['pricePerUnit'];
                    quantity = loadedData[index]['quantity'];
                    return Card(
                      child: Row(
                        children: [
                          Expanded(child: Text(dateTime)),

                          Expanded(child: Text(name)),

                          Expanded(child: Text(potency)),

                          Expanded(child: Text(quantity)),

                          Expanded(child: Text(price)),
                          Expanded(child: Text(totalPrice)),
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
