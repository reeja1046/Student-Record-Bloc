part of 'view_records_bloc.dart';

@immutable
abstract class ViewRecordsEvent {}

class ViewStudentRecord extends ViewRecordsEvent {}

// ignore: must_be_immutable
class DeleteStudentRecord extends ViewRecordsEvent {
  int index;
  DeleteStudentRecord({required this.index});
}
