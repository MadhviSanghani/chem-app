import 'package:flutter/material.dart';
import 'add_equipment.dart';

class EquipmentDatabase extends StatelessWidget {
  const EquipmentDatabase({Key? key}) : super(key: key);

  // Static data for equipment
  List<Map<String, dynamic>> _fetchEquipments() {
    return [
      {
        'id': '1',
        'image_url': 'assets/pipette.webp',
        'name': 'Pipette',
      },
      {
        'id': '2',
        'image_url': 'assets/testtube.webp',
        'name': 'Testtube',
      },
      {
        'id': '3',
        'image_url': 'assets/watch-glass.jpeg',
        'name': 'Watch Glass',
      },
    ];
  }

  Future<void> _deleteEquipment(String id) async {
    // Simulate a delete action
    print('Deleted equipment with id: $id');
  }

  @override
  Widget build(BuildContext context) {
    final equipments = _fetchEquipments();

    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: Text('Equipments'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Colors.white,
              child: DataTable(
                columnSpacing: 20.0,
                dataRowHeight: 120.0,
                columns: [
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Action')),
                ],
                rows: equipments.map((equipment) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Image.asset(
                          equipment['image_url'],
                          width: 100, // Set image width
                          height: 100, // Set image height
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                      ),
                      DataCell(Text(equipment['name'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () async {
                            await _deleteEquipment(equipment['id']);
                          },
                          child: Text('Delete'),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEquipmentPage(),
            ),
          );
          print('Add Equipment');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
