import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record_bloc/bloc/image_picker/image_picker_bloc.dart';
import 'package:student_record_bloc/database/functions/db_functions.dart';
import 'package:student_record_bloc/database/models/db_models.dart';
import 'package:student_record_bloc/screens/screen_view.dart';

import '../core/constants.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _courseController = TextEditingController();
  //  final _imageController = ImagePicker();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Students',
          style: kAppBarText,
        ),
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
                      
                        image = state.image;
                        log(image.toString());
                        return Stack(
                          children: [
                            CircleAvatar(
                                backgroundImage: image != null
                                    ? FileImage(File(image!.path))
                                        as ImageProvider
                                    : const NetworkImage(
                                        'https://tse1.mm.bing.net/th?id=OIP.uuLTfEMXFApAiu9mcTRhhgHaHa&pid=Api&P=0'),
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
                  kAddScreenDisplay(
                      _nameController, TextInputType.text, 'Enter your name'),
                  kHeight20,
                  kAddScreenDisplay(_courseController, TextInputType.text,
                      'Enter your course'),
                  kHeight20,
                  kAddScreenDisplay(
                      _ageController, TextInputType.number, 'Enter your age'),
                  kHeight20,
                  ElevatedButton(
                    onPressed: () async {
                      await onAddStudentButtonClicked();
                      BlocProvider.of<ImagePickerBloc>(context)
                          .add(RemoveImage());
                    },
                    child: const Text(
                      'Save',
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

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();
    final age = _ageController.text.trim();
    final String? selectedImage;

    if (image == null) {
      selectedImage = '';
    } else {
      selectedImage = image!.path;
    }

    if (name.isEmpty ||
        age.isEmpty ||
        course.isEmpty ||
        selectedImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("All Fields are Required!!!"),
          duration: Duration(seconds: 2)));
      return;
    }

    int ageValid = int.parse(age);
    if (ageValid <= 0 || ageValid > 100) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Enter the correct age"),
          duration: Duration(seconds: 2)));
      return;
    }
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');
    if (!regex.hasMatch(name)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Please enter a valid name"),
          duration: Duration(seconds: 2)));
      return;
    }

    if (!regex.hasMatch(course)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Please enter a valid course"),
          duration: Duration(seconds: 2)));
      return;
    }

    String nameValid = name;
    String courseValid = course;
    if (nameValid.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Please enter a valid name "),
          duration: Duration(seconds: 2)));
      return;
    }
    if (courseValid.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Please enter a valid course "),
          duration: Duration(seconds: 2)));
      return;
    }

    final student = StudentModel(
        name: name, age: age, course: course, image: selectedImage);
    await addStudent(student);
    log('<<<<<<<<<00000>>>>>>>>>');
    log(student.name);
    log(student.age);
    log(student.course);
    log(student.image);
    log('<<<<<<<<<<added>>>>>>>>>>');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.purple,
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text("Item added Successfully"),
        duration: Duration(seconds: 2)));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ViewRecordsScreen(),
      ),
    );
  }
}
