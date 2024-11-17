import 'package:admin_login/experiment/add_experimet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExperimentPage extends StatefulWidget {
  const ExperimentPage({Key? key}) : super(key: key);

  @override
  _ExperimentPageState createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  // Method to delete an experiment document from Firestore
  Future<void> _deleteExperiment(String id) async {
    try {
      await FirebaseFirestore.instance.collection('experiment').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Experiment deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting experiment: $e')),
      );
    }
  }

  // Method to show edit dialog
  Future<void> _showEditDialog(String id, Map<String, dynamic> currentData) async {
    final _nameController = TextEditingController(text: currentData['name'] ?? '');
    final _descriptionController = TextEditingController(text: currentData['description'] ?? '');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Experiment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Experiment Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Update the experiment document in Firestore
                  await FirebaseFirestore.instance
                      .collection('experiment')
                      .doc(id)
                      .update({
                    'name': _nameController.text.trim(),
                    'description': _descriptionController.text.trim(),
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Experiment updated successfully')),
                  );

                  Navigator.pop(context); // Close the dialog
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating experiment: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Experiments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('experiment').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No experiments found.'));
          }

          final experiments = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Enable vertical scrolling
              child: DataTable(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Experiment')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: experiments.asMap().entries.map((entry) {
                  final index = entry.key + 1; // Serial number
                  final experiment = entry.value.data() as Map<String, dynamic>;
                  final docId = entry.value.id; // Document ID for deletion

                  return DataRow(
                    cells: [
                      DataCell(Text(index.toString())), // No
                      DataCell(Text(experiment['name'] ?? 'N/A')), // Experiment name
                      DataCell(Text(experiment['description'] ?? 'N/A')), // Description
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _deleteExperiment(docId);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditDialog(docId, experiment);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add experiment page navigation
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExperimentPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
