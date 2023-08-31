import 'package:hive_flutter/hive_flutter.dart';
part 'db_models.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String course;

  @HiveField(3)
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.course,
      required this.image});
}
