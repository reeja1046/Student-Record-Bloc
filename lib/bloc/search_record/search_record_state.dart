part of 'search_record_bloc.dart';

class SearchRecordState {}

class SearchRecordInitial extends SearchRecordState {}

class SearchLoadedState extends SearchRecordState {
  final List<StudentModel> displaylist;
  final List<StudentModel> allStudentList;
  SearchLoadedState({required this.displaylist, required this.allStudentList});
}

class SearchErrorState extends SearchRecordState {}

class SearchLoadingState extends SearchRecordState {}
