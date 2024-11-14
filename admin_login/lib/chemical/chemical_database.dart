import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_chemical.dart';

class ChemicalListScreen extends StatelessWidget {
  const ChemicalListScreen({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> _fetchChemicals() {
    return FirebaseFirestore.instance.collection('chemical').snapshots().map(
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

  Future<void> _deleteChemical(String id) async {
    try {
      await FirebaseFirestore.instance.collection('chemical').doc(id).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: Text('Chemicals'),
      ),
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _fetchChemicals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No chemicals found.');
            }

            final chemicals = snapshot.data!;

            return SingleChildScrollView(
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
                        Image.network(
                          chemical['image_url'],
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                      ),
                      DataCell(Text(chemical['name'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () async {
                            await _deleteChemical(chemical['id']);
                            print('Deleted ${chemical['name']}');
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
              builder: (context) => const AddChemical(),
            ),
          );
          print('Add Chemical');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
