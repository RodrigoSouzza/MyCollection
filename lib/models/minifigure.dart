import 'package:hive/hive.dart';

part 'minifigure.g.dart';

@HiveType(typeId:0)
class Minifigure {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String collection;

  @HiveField(2)
  final String? imagePath;

  Minifigure({
    required this.name,
    required this.collection,
    this.imagePath,
  });
}

