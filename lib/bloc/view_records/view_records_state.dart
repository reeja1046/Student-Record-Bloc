part of 'view_records_bloc.dart';

class ViewRecordsState {
  List<StudentModel> studentrecodList;
  ViewRecordsState({
    required this.studentrecodList,
  });
}

class ViewRecordsInitial extends ViewRecordsState {
  ViewRecordsInitial() : super(studentrecodList: []);
}
