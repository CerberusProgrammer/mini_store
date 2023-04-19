import 'package:mini_store/object/category.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;
  Category category;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    this.price = 0,
    this.disponibility = 0,
    required this.category,
  });
}
