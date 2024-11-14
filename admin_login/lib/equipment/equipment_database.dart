import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_equipment.dart';

class EquipmentDatabase extends StatelessWidget {
  const EquipmentDatabase({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> _fetchEquipments() {
    return FirebaseFirestore.instance.collection('equipment').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'image_url': doc['image_url'] ?? '',
            'name': doc['name'] ?? '',
          };
        }).toList();
      },
    );
  }

  Future<void> _deleteEquipment(String id) async {
    try {
      await FirebaseFirestore.instance.collection('equipment').doc(id).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: Text('Equipments'),
      ),
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _fetchEquipments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No equipment found.');
            }

            final equipments = snapshot.data!;

            return SingleChildScrollView(
              child: DataTable(
                columnSpacing: 30.0,
                dataRowHeight: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                columns: [
                  DataColumn(label: Text('Equipment')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: equipments.map((equipment) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Image.network(
                          equipment['image_url'],
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                      ),
                      DataCell(Text(equipment['name'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () async {
                            await _deleteEquipment(equipment['id']);
                            print('Deleted ${equipment['name']}');
                          },
                          child: Text('Delete'),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
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
