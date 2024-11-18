import 'package:admin_login/chemical/chemical_database.dart';
import 'package:admin_login/equipment/equipment_database.dart';
import 'package:admin_login/experiment/add_experimet.dart';
import 'package:admin_login/experiment/experiment_database.dart';
import 'package:admin_login/login/login.dart';
import 'package:admin_login/user/user_database.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC), // Set background color
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Admin Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF4E93A3), // Set background color for each item
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Users',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigate to the UsersScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserListScreen()),
                        );

                      },
                    ),
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF4E93A3), // Set background color for each item
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Chemical',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigate to the Chemical page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChemicalListScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF4E93A3), // Set background color for each item
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Experiments',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigate to the Experiments page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExperimentPage()),
                        );
                      },
                    ),
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF4E93A3), // Set background color for each item
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Equipment',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigate to the Equipment page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EquipmentDatabase()),
                        );
                      },
                    ),
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF4E93A3), // Set background color for each item
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Implement logout logic
                        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLoginPage(), // Replace with your next page widget
                  ),
                );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
