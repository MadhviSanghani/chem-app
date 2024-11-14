import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddExperimentPage extends StatefulWidget {
  const AddExperimentPage({Key? key}) : super(key: key);

  @override
  _AddExperimentPageState createState() => _AddExperimentPageState();
}

class _AddExperimentPageState extends State<AddExperimentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Dispose controllers to free up resources
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to add experiment to Firestore
  Future<void> _addExperiment() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String description = _descriptionController.text.trim();

      try {
        await FirebaseFirestore.instance.collection('experiment').add({
          'name': name,
          'description': description,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Experiment added successfully')),
        );

        // Clear the form
        _formKey.currentState!.reset();
      } catch (e) {
        // Handle errors (e.g., network issues)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add experiment: $e')),
        );
        print("Error adding experiment: $e");
      }
    }
  }

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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a name for the experiment';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description for the experiment';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Add Button
                    ElevatedButton(
                      onPressed: _addExperiment,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
