import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator while data is loading
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No users found'); // Handle case with no data
            }

            final List<QueryDocumentSnapshot> users = snapshot.data!.docs;

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
                    DataColumn(label: Text('Srno')),
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Password')),
                  ],
                  rows: users.asMap().entries.map((entry) {
                    final index = entry.key + 1; // Add 1 for Srno
                    final user = entry.value.data() as Map<String, dynamic>;

                    return DataRow(
                      cells: [
                        DataCell(Text(index.toString())), // Srno
                        DataCell(Text(user['username'] ?? 'N/A')), // Username
                        DataCell(Text(user['password'] ?? 'N/A')), // Password
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
