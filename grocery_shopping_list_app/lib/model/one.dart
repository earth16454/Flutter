import 'package:hive/hive.dart';
part 'two.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String time;

  Todo({required this.name, required this.time});
}
