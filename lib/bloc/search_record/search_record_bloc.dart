import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_record_bloc/database/functions/db_functions.dart';
import 'package:student_record_bloc/database/models/db_models.dart';

part 'search_record_event.dart';
part 'search_record_state.dart';

class SearchRecordBloc extends Bloc<SearchRecordEvent, SearchRecordState> {
  SearchRecordBloc() : super(SearchRecordInitial()) {
    on<IdleEvent>(idleEvent);
    on<SearchingEvent>(searchingEvent);
  }

  FutureOr<void> idleEvent(IdleEvent event, Emitter<SearchRecordState> emit) {
    log('IdleResults');
    emit(SearchLoadingState());
    List<StudentModel> studentlist = studentDB.values.toList();
    emit(SearchLoadedState(
        displaylist: studentlist, allStudentList: studentlist));
  }

  FutureOr<void> searchingEvent(
      SearchingEvent event, Emitter<SearchRecordState> emit) {
    log('IdleResults');
    emit(SearchLoadingState());
    List<StudentModel> studentlist = studentDB.values.toList();
    List<StudentModel> searchingList = studentlist
        .where((element) =>
            element.name.toLowerCase().contains(event.textQuery.toLowerCase()))
        .toList();
    emit(SearchLoadedState(
        displaylist: searchingList, allStudentList: studentlist));
  }
}
