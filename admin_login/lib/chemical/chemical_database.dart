import 'package:admin_login/chemical/add_chemical.dart';
import 'package:flutter/material.dart';

class ChemicalListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chemicals = [
    {'image': 'assets/h2so4.jpg', 'name': 'H2SO4'},
    {'image': 'assets/ch3cooh.webp', 'name': 'CH3COOH'},
    {'image': 'assets/naoh.webp', 'name': 'NaOH'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: Text('Chemicals'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 30.0,
            dataRowHeight: 70,
             decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            columns: [
              DataColumn(label: Text('Chemical')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Delete')),
            ],
            rows: chemicals.map((chemical) {
              return DataRow(
                cells: [
                  DataCell(
                      Image.asset(chemical['image'], width: 50, height: 50)),
                  DataCell(Text(chemical['name'])),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        // Implement delete logic here
                        print('Delete ${chemical['name']}');
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                          //primary: Colors.red,
                          ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddChemical(), // Replace with your next page widget
                  ),
                );
          print('Add Chemical');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
