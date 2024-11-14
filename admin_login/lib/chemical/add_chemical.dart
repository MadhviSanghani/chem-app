import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddChemical extends StatefulWidget {
  const AddChemical({Key? key}) : super(key: key);

  @override
  _AddChemicalState createState() => _AddChemicalState();
}

class _AddChemicalState extends State<AddChemical> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _uploadData() async {
    if (_selectedImage == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide both name and image')),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chemicals/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(File(_selectedImage!.path));
      final imageUrl = await storageRef.getDownloadURL();

      // Save chemical data to Firestore
      await FirebaseFirestore.instance.collection('chemicals').add({
        'name': _nameController.text,
        'image_url': imageUrl,
      });

      // Clear form and show success message
      _nameController.clear();
      setState(() {
        _selectedImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chemical added successfully')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Add Chemical'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Choose file'),
                      ),
                      ElevatedButton(
                        onPressed: _uploadData,
                        child: const Text('Upload image and add'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  if (_selectedImage != null)
                    Image.file(
                      File(_selectedImage!.path),
                      width: 100,
                      height: 100,
                    ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name for the chemical';
                      }
                      return null;
                    },
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
