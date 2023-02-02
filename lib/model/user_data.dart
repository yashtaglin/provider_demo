import 'package:hive/hive.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  UserData(
      {this.name,this.age});
}