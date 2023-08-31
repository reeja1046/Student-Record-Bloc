import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/view_records/view_records_bloc.dart';
import 'package:student_record_bloc/screens/screen_profile.dart';
import 'package:student_record_bloc/screens/screen_search.dart';

import '../core/constants.dart';

class ViewRecordsScreen extends StatelessWidget {
  const ViewRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ViewRecordsBloc>(context).add(ViewStudentRecord());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Student List',
          style: kAppBarText,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<ViewRecordsBloc, ViewRecordsState>(
        builder: (context, state) {
          if (state.studentrecodList.isEmpty) {
            return Scaffold(
              body: Container(
                decoration: kScaffoldbgClr,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.hourglass_empty,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        'No Records Found',
                        style: kCenterText.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
            decoration: kScaffoldbgClr,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = state.studentrecodList[index];
                  return Card(
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(index: index),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(File(data.image)),
                      ),
                      title: Text(data.name),
                      subtitle: const Text('Click to get info'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                        onPressed: () {
                          showAlertDialogue(ctx, index);
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: state.studentrecodList.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
