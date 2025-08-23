import 'package:flutter/material.dart';
import '../models/minifigure.dart';

class MinifigureProvider with ChangeNotifier {
  final List<Minifigure> _items = [];

  List<Minifigure> get items => List.unmodifiable(_items);

  void addMinifigure(Minifigure minifigure) {
    _items.add(minifigure);
    notifyListeners();
  }
}