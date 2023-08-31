import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/search_record/search_record_bloc.dart';
import 'package:student_record_bloc/core/constants.dart';
import 'package:student_record_bloc/screens/screen_profile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final stu
    BlocProvider.of<SearchRecordBloc>(context).add(IdleEvent());
    final _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              onChanged: (value) => BlocProvider.of<SearchRecordBloc>(context)
                  .add(SearchingEvent(textQuery: value)),
              controller: _searchController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        _searchController.clear();
                        BlocProvider.of<SearchRecordBloc>(context)
                            .add(IdleEvent());
                      }),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchRecordBloc, SearchRecordState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is SearchLoadedState) {
            if (state.displaylist.isEmpty) {
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
                    final data = state.displaylist[index];
                    return Card(
                      color: Colors.white54,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                  index: state.allStudentList.indexWhere(
                                      (student) => student.name == data.name)),
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
                  itemCount: state.displaylist.length,
                ),
              ),
            );
          } else {
            return const Text('Something Went Wrong');
          }
        },
      ),
    );
  }
}
