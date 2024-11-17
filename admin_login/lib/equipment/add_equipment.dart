import 'dart:typed_data'; // For handling image bytes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  _AddEquipmentState createState() => _AddEquipmentState();
}

class _AddEquipmentState extends State<AddEquipmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Uint8List? _imageBytes; // To store image bytes for web
  bool _isUploading = false; // To handle loading state

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes; // Store image bytes
      });
    }
  }

  // Function to upload data (image + name) to Firebase
  Future<void> _uploadData() async {
    if (_imageBytes == null || _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide both name and image')),
      );
      return;
    }

    setState(() {
      _isUploading = true; // Show loading spinner
    });

    try {
      // Upload image to Firebase Storage
      final String fileName =
          'equipments/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      print('Storage Reference Path: ${storageRef.fullPath}');
      print('Filename' + fileName);
       
      final TaskSnapshot uploadTask = await storageRef.putData(_imageBytes!);
      // if (kDebugMode) {
      //   print('uploadtask:'+uploadTask);
      // }
      final String imageUrl = await uploadTask.ref.getDownloadURL(); // Get image URL
      print('imageurl:'+imageUrl);

      // Save chemical data to Firestore
      await FirebaseFirestore.instance.collection('euipments').add({
        'image': _nameController.text.trim(),
        'name': imageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });

      // Clear the form and reset
      _nameController.clear();
      setState(() {
        _imageBytes = null;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Equipment added successfully')),
      );
    } catch (e) {
      print("Error uploading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading data: $e')),
      );

      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Add Equipment'),
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
                  // Choose file and upload buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Choose file'),
                      ),
                      ElevatedButton(
                        onPressed: _isUploading ? null : _uploadData,
                        child: _isUploading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Upload image and add'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // Display selected image
                  if (_imageBytes != null)
                    Image.memory(
                      _imageBytes!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),

                  const SizedBox(height: 16.0),

                  // Name input field
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name for the equipment';
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
