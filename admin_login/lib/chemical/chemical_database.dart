import 'package:flutter/material.dart';
import 'add_chemical.dart';

class ChemicalListScreen extends StatelessWidget {
   ChemicalListScreen({Key? key}) : super(key: key);

  // Static list of chemicals
  final List<Map<String, dynamic>> chemicals = [
    {'id': 1, 'image_url': 'assets/ch3cooh.webp', 'name': 'CH3COOH'},
    {'id': 2, 'image_url': 'assets/h2so4.jpg', 'name': 'H2SO4'},
    {'id': 3, 'image_url': 'assets/koh.webp', 'name': 'KOH'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Chemicals'),
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
            columns: const [
              DataColumn(label: Text('Chemical')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Delete')),
            ],
            rows: chemicals.map((chemical) {
              return DataRow(
                cells: [
                  DataCell(
                    Image.network(
                      chemical['image_url'] ?? '',
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  DataCell(Text(chemical['name'] ?? '')),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        // Remove the selected chemical (static example)
                        chemicals.remove(chemical);
                        print('Deleted ${chemical['name']}');
                      },
                      child: const Text('Delete'),
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
              builder: (context) => const AddChemical(),
            ),
          );
          print('Add Chemical');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
