import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/view_records/view_records_bloc.dart';
import 'package:student_record_bloc/core/constants.dart';
import 'package:student_record_bloc/screens/screen_update.dart';

class ProfileScreen extends StatelessWidget {
  final int index;
  const ProfileScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: BlocBuilder<ViewRecordsBloc, ViewRecordsState>(
        builder: (context, state) {
          final data = state.studentrecodList[index];
          return Container(
            decoration: kScaffoldbgClr,
            child: Center(
              child: Column(
                children: [
                  kHeight80,
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(data.image)),
                  ),
                  kHeight20,
                  display("Name  :", data.name),
                  kHeight20,
                  display("Course  :", data.course),
                  kHeight20,
                  display("Age  :", data.age),
                  kHeight20,
                  ElevatedButton.icon(
                    onPressed: () {
                      log('<<<<<<<profile>>>>>>>');
                      log(data.name);
                      log(data.age);
                      log(data.image);
                      log(data.course);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            index: index,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Update',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget display(field, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          field,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
