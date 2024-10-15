import 'package:admin_login/experiment/add_experimet.dart';
import 'package:flutter/material.dart';

class ExperimentPage extends StatefulWidget {
  const ExperimentPage({Key? key}) : super(key: key);

  @override
  _ExperimentPageState createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  final List<Experiment> experiments = [
    Experiment(
      no: 1,
      name: 'Titration',
      description:
          'A technique used to measure the volume of a solution of known concentration that is required to react with a measured amount (mass or volume) of an unknown substance in solution.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BCDDC),
      appBar: AppBar(
        title: const Text('Experiment'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
            rows: experiments.map((experiment) {
              return DataRow(
                cells: [
                  DataCell(Text(experiment.no.toString())),
                  DataCell(Text(experiment.name)),
                  DataCell(Text(experiment.description)),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Handle experiment deletion here
                            setState(() {
                              experiments.remove(experiment);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Handle experiment editing here
                            // Navigate to an edit experiment page
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add experiment page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExperimentPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Experiment {
  final int no;
  final String name;
  final String description;

  Experiment({required this.no, required this.name, required this.description});
}
