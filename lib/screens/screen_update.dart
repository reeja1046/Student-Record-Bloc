import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/image_picker/image_picker_bloc.dart';
import 'package:student_record_bloc/core/constants.dart';
import 'package:student_record_bloc/database/functions/db_functions.dart';
import 'package:student_record_bloc/database/models/db_models.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatelessWidget {
  final int index;
  UpdateScreen({
    super.key,
    required this.index,
  });

  final _updateNameController = TextEditingController();

  final _updateAgeController = TextEditingController();

  final _updateCourseController = TextEditingController();

  String? imageUrl;
  final allDbList = studentDB.values.toList();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ImagePickerBloc>(context).add(RemoveImage());
    });
    final student = allDbList[index];
    _updateNameController.text = student.name;
    _updateAgeController.text = student.age;
    _updateCourseController.text = student.course;
    //image = student.image;
    log('<<<<<<<updating>>>>>>>');
    log(student.name);
    log(student.age);
    log(student.image);
    log(student.course);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
        centerTitle: true,
      ),
      body: Container(
        decoration: kScaffoldbgClr,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ImagePickerBloc, ImagePickerState>(
                    builder: (context, state) {
                        // imageUrl = state.image!.path;
                      log(imageUrl.toString());
                      return Stack(
                        children: [
                          CircleAvatar(
                              backgroundImage: imageUrl != null
                                  ? FileImage(File(imageUrl!))
                                  : FileImage(File(student.image))
                                      as ImageProvider,
                              radius: 90),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<ImagePickerBloc>(context).add(
                                  ChooseImage(),
                                );
                              },
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  kHeight20,
                  kAddScreenDisplay(_updateNameController, TextInputType.text,
                      'Enter your name'),
                  kHeight20,
                  kAddScreenDisplay(_updateCourseController, TextInputType.text,
                      'Enter your course'),
                  kHeight20,
                  kAddScreenDisplay(_updateAgeController, TextInputType.number,
                      'Enter your age'),
                  kHeight20,
                  ElevatedButton(
                    onPressed: () async {
                      await onUpdateStudentButtonClicked(index, context);
                      BlocProvider.of<ImagePickerBloc>(context)
                          .add(RemoveImage());
                    },
                    child: const Text(
                      'Update',
                      style: kButtonTxtStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onUpdateStudentButtonClicked(index, context) async {
    final updatedname = _updateNameController.text.trim();
    final updatedcourse = _updateCourseController.text.trim();
    final updatedage = _updateAgeController.text.trim();
    final updatedImage = imageUrl;
    log('<<<<<<<<<<updated>>>>>>>>>>');
    log(updatedname);
    log(updatedcourse);
    log(updatedage);
    log(updatedImage.toString());

    if (updatedname.isEmpty || updatedage.isEmpty || updatedcourse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("All Fields are Required!!!"),
          duration: Duration(seconds: 2)));
      return;
    }
    if (updatedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Choose an image!!!"),
          duration: Duration(seconds: 2)));
      return;
    }

    int ageValid = int.parse(updatedage);
    if (ageValid <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Age Should be Greater Than 0"),
          duration: Duration(seconds: 2)));
      return;
    }
    final updatedStudent = StudentModel(
        name: updatedname,
        age: updatedage,
        course: updatedcourse,
        image: updatedImage);

    await updateStudent(updatedStudent, index);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.purple,
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text("Updated Successfully"),
        duration: Duration(seconds: 2),
      ),
    );
    // BlocProvider.of<ViewRecordsBloc>(context).add(ViewStudentRecord());
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProfileScreen(index: widget.index),
    //   ),
    // );
    Navigator.pop(context);
  }
}
