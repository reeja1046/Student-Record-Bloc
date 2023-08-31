import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_bloc/database/models/db_models.dart';
late Box<StudentModel> studentDB;

Future<void> openStudentBox() async {
  studentDB = await Hive.openBox<StudentModel>('student_db');
}

Future<void> addStudent(StudentModel value) async {
  //final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
}

// Future<List<StudentModel>> getAllStudents() async {
//   return studentDB.values.toList();
// }

// Future<void> deleteStudent(int id) async {
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   await studentDB.deleteAt(id);
//   //getAllStudents();
// }

Future<void> updateStudent(StudentModel updatedValue, id) async {
  await studentDB.putAt(id, updatedValue);
  //  getAllStudents();
}
