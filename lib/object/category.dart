import 'package:flutter/material.dart';

class Category {
  String name;
  String description;
  Icon icon;
  Color color;

  Category({
    required this.name,
    this.description = '',
    this.icon = const Icon(Icons.store),
    this.color = Colors.lightBlue,
  });
}
