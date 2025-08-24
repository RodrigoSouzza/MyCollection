import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/minifigure.dart';

class MinifigureProvider with ChangeNotifier {
  final List<Minifigure> _items = [];
  late Box<Minifigure> _box;

  MinifigureProvider(){
    _init();
  }
  Future<void> _init() async {
    _box = Hive.box<Minifigure>('minifigures');
    _items.addAll(_box.values);
    notifyListeners();
  }

  List<Minifigure> get items => List.unmodifiable(_items);

  void addMinifigure(Minifigure minifigure) {
    _items.add(minifigure);
    _box.add(minifigure);
    notifyListeners();
  }

  void updateMinifigure(int index, Minifigure updated) {
    _items[index] = updated;
    _box.putAt(index, updated);
    notifyListeners();
  }

  void deleteMinifigure(int index) {
    _items.removeAt(index);
    _box.deleteAt(index);
    notifyListeners();
  }
}