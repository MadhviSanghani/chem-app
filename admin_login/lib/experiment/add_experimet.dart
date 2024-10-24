import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddExperimentPage extends StatefulWidget {
  const AddExperimentPage({Key? key}) : super(key: key);

  @override
  _AddExperimentPageState createState() => _AddExperimentPageState();
}

class _AddExperimentPageState extends State<AddExperimentPage> {
  //final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

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
                    //   Map<String, dynamic> data = {
                    //     "name": _nameController.text.toString(),
                    //     "description": _descriptionController.text.toString(),
                    //   };

                    //   try {
                    //     await dbRef.child("Experiment").push().set(data);
                    //     Navigator.of(context).pop();
                    //   } catch (error) {
                    //     // Handle errors here, e.g., show a snackbar or a dialog
                    //     print("Error writing data to Firebase: $error");
                    //   }
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
