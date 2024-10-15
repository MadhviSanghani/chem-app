import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {'Srno': 1, 'Username': 'Priyal', 'Password': 'P5ri67rs'},
    {'Srno': 2, 'Username': 'Madhvi', 'Password': 'M@dh5'},
    {'Srno': 3, 'Username': 'Khushi', 'Password': 'kRg7342'},
    {'Srno': 4, 'Username': 'Karan', 'Password': 'k*ra679f'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: DataTable(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            columns: [
              DataColumn(label: Text('Srno')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Password')),
            ],
            rows: users.map((user) {
              return DataRow(
                cells: [
                  DataCell(Text(user['Srno'].toString())),
                  DataCell(Text(user['Username'])),
                  DataCell(Text(user['Password'])),
                ],
              );
            }).toList(),
            // horizontalSeparatorBuilder: (int index, bool selected) => Divider(color: Colors.black),
            // verticalSeparatorBuilder: (int index, bool selected) => Divider(color: Colors.black),
          ),
        ),
      ),
    );
  }
}