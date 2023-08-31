// import 'dart:async';
import 'package:bloc/bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:student_record_bloc/database/functions/db_functions.dart';
import 'package:student_record_bloc/database/models/db_models.dart';
part 'view_records_event.dart';
part 'view_records_state.dart';

class ViewRecordsBloc extends Bloc<ViewRecordsEvent, ViewRecordsState> {
  ViewRecordsBloc() : super(ViewRecordsInitial()) {
    on<ViewStudentRecord>(
      (event, emit) async {
        //studentDB = await Hive.openBox<StudentModel>('student_db');
        List<StudentModel> studentList = studentDB.values.toList();
        return emit(ViewRecordsState(studentrecodList: studentList));
      },
    );
    on<DeleteStudentRecord>(
      (event, emit) {
        studentDB.deleteAt(event.index);
        List<StudentModel> studentList = studentDB.values.toList();
        return emit(ViewRecordsState(studentrecodList: studentList));
      },
    );
    
  }
}
