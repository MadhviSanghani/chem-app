import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> experiments_add(String name, String description) async {
  CollectionReference experiments = FirebaseFirestore.instance.collection('experiments');

  await experiments.add({
    'name': name,
    'description': description,
    'createdAt': FieldValue.serverTimestamp(),
  });
}

class AddExperimentPage extends StatefulWidget {
  const AddExperimentPage({Key? key}) : super(key: key);

  @override
  _AddExperimentPageState createState() => _AddExperimentPageState();
}

class _AddExperimentPageState extends State<AddExperimentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Add Experiment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 500,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name for the experiment';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description for the experiment';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Validate the form fields
                      if (_formKey.currentState!.validate()) {
                        try {
                          await experiments_add(
                            _nameController.text,
                            _descriptionController.text,
                          );
                          Navigator.of(context).pop(); // Go back after successful addition
                        } catch (error) {
                          // Handle errors here, e.g., show a snackbar or a dialog
                          print("Error adding data to Firebase: $error");
                        }
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
