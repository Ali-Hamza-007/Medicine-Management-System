import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewSupplierStockPage extends StatefulWidget {
  const ViewSupplierStockPage({super.key});

  @override
  State<ViewSupplierStockPage> createState() => _ViewMedicineStockPageState();
}

class _ViewMedicineStockPageState extends State<ViewSupplierStockPage> {
  List loadedData = [];
  String representativeName = '';

  String companyName = '';
  String description = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final result =
          await FirebaseFirestore.instance.collection('Supplier').get();

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
        appBar: AppBar(title: Text('View Supplier Stock'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'CompanyName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    //  Spacer(),
                    Expanded(
                      child: Text(
                        'RepresentativeName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      child: Text(
                        'Description',
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
                    companyName = loadedData[index]['companyName'];
                    representativeName =
                        loadedData[index]['representativeName'];
                    description = loadedData[index]['description'];
                    return Card(
                      child: Row(
                        children: [
                          Expanded(child: Text(companyName)),

                          Expanded(child: Text(representativeName)),

                          Expanded(child: Text(description)),
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
