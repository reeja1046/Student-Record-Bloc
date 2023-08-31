part of 'search_record_bloc.dart';

@immutable
abstract class SearchRecordEvent {}

class IdleEvent extends SearchRecordEvent {}

// ignore: must_be_immutable
class SearchingEvent extends SearchRecordEvent {
  String textQuery;
  SearchingEvent({required this.textQuery});
}


