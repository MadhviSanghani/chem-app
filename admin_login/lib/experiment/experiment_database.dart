// import 'package:admin_login/experiment/add_experimet.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';


// class ExperimentPage extends StatefulWidget {
//   const ExperimentPage({Key? key}) : super(key: key);

//   @override
//   _ExperimentPageState createState() => _ExperimentPageState();
// }

// class _ExperimentPageState extends State<ExperimentPage> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF8BCDDC),
//       appBar: AppBar(
//         title: const Text('Experiments'),
//       ),
//        body: 
//       //StreamBuilder<List<Map<String, dynamic>>>(
//       //   stream: _fetchExperiments(),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.connectionState == ConnectionState.waiting) {
//       //       return Center(child: CircularProgressIndicator());
//       //     } else if (snapshot.hasError) {
//       //       return Center(child: Text('Error: ${snapshot.error}'));
//       //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//       //       return Center(child: Text('No experiments found.'));
//       //     }

//       //     final experiments = snapshot.data!;

//          SingleChildScrollView(
//             child: Center(
//               child: DataTable(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.black),
//                 ),
//                 columns: const [
//                   DataColumn(label: Text('No')),
//                   DataColumn(label: Text('Experiment')),
//                   DataColumn(label: Text('Description')),
//                   DataColumn(label: Text('Actions')),
//                 ],
//                 rows: 
//                 experiments.map((experiment) {
//                   return DataRow(
//                     cells: [
//                       DataCell(Text(experiment['no'].toString())),
//                       DataCell(Text(experiment['name'])),
//                       DataCell(Text(experiment['description'])),
//                       DataCell(
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () async {
//                                 await _deleteExperiment(experiment['id']);
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () {
//                                 // Navigate to edit page (implement if needed)
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddExperimentPage()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
