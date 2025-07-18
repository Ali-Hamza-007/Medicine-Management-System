import 'package:flutter/material.dart';
import 'package:pharmacy_management_system_flutter/Pages/Supplier/editSupplierDialogue.dart';
import 'Medicine/AddMedicinePage.dart';
import 'Medicine/DeleteMedicinePage.dart';
import 'Medicine/ViewMedicineStockPage.dart';
import 'Supplier/AddSupplierPage.dart';
import 'Supplier/DeleteSupplierPage.dart';
import 'Supplier/ViewSupplierStockPage.dart';
import 'ProfilePage.dart';
import 'Medicine/editMedDialogue.dart';
import 'Purchase/purchaseInvoicePage.dart';
import 'Purchase/purchaseReportPage.dart';
import 'Sale/saleInvoicePage.dart';
import 'Sale/saleReportPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String?> selectedValues = {
    'Medicine': null,
    'Supplier': null,
  };
  void _handleNavigation(String section, String option) {
    if (section == 'Manage Medicine') {
      switch (option) {
        case 'Add Medicine':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMedicinePage()),
          );
          break;
        case 'Edit Medicine':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => editMedDialgue()),
          );
          break;
        case 'Delete Medicine':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DeleteMedicinePage()),
          );
          break;
        case 'View Medicine Stock':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ViewMedicineStockPage()),
          );
          break;
      }
    } else if (section == 'Manage Supplier') {
      switch (option) {
        case 'Add Supplier':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddSupplierPage()),
          );
          break;
        case 'Edit Supplier':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => editSupplierDialgue()),
          );
          break;
        case 'Delete Supplier':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DeleteSupplierPage()),
          );
          break;
        case 'View Supplier Stock':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ViewSupplierStockPage()),
          );
          break;
      }
    } else if (section == 'Record the Sale') {
      switch (option) {
        case 'Generate Sale Invoice':
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => SaleInvoicePage()));
          break;
      }
    } else if (section == 'Record the Purchase') {
      switch (option) {
        case 'Generate Purchase Invoice':
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => PurchaseInvoicePage()));
          break;
      }
    } else if (section == 'Reports') {
      switch (option) {
        case 'Generate Purchase Report':
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => PurchaseReportPage()));
          break;
        case 'Generate Sales Report':
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => SaleReportPage()));
          break;
      }
    }
  }

  Widget _section({required String txt, required List<String> optionsList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButtonFormField<String>(
            value: selectedValues[txt],
            items:
                optionsList
                    .map(
                      (option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                        onTap: () {},
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedValues[txt] = value;
              });
              _handleNavigation(txt, value!);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Medicine Management System',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              child: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
            ),
          ],
          actionsPadding: EdgeInsets.all(8),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Developed By HAMZA </>',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: ListView(
          children: [
            _section(
              txt: 'Manage Medicine',
              optionsList: [
                'Add Medicine',
                'Edit Medicine',
                'Delete Medicine',
                'View Medicine Stock',
              ],
            ),
            _section(
              txt: 'Manage Supplier',
              optionsList: [
                'Add Supplier',
                'Edit Supplier',
                'Delete Supplier',
                'View Supplier Stock',
              ],
            ),
            _section(
              txt: 'Record the Sale',
              optionsList: ['Generate Sale Invoice'],
            ),
            _section(
              txt: 'Record the Purchase',
              optionsList: ['Generate Purchase Invoice'],
            ),
            _section(
              txt: 'Reports',
              optionsList: [
                'Generate Sales Report',
                'Generate Purchase Report',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
