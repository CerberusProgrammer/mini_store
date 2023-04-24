import 'package:flutter/material.dart';
import 'package:mini_store/object/product.dart';

import '../object/category.dart';

List<Category> categories = [
  Category(
    name: 'Food',
    color: Colors.red,
    icon: Icons.fastfood,
  ),
  Category(
    name: 'Clothing and Accesories',
    color: Colors.pink,
    icon: Icons.checkroom,
  ),
  Category(
    name: 'Electronics',
    color: Colors.purple,
    icon: Icons.devices,
  ),
  Category(
    name: 'Home and Garden',
    color: Colors.green,
    icon: Icons.home,
  ),
  Category(
    name: 'Healthy and Beauty',
    color: Colors.orange,
    icon: Icons.spa,
  ),
  Category(
    name: 'Toys and Games',
    color: Colors.amber,
    icon: Icons.sports_esports,
  ),
  Category(
    name: 'Sports and Outdoors',
    color: Colors.blue,
    icon: Icons.hiking,
  ),
];

class Categories {
  static void initCategories() {
    categories[0].products = [
      Product(id: 0, name: 'Nintendo'),
      Product(id: 0, name: 'Xbox'),
      Product(id: 0, name: 'PlayStation'),
      Product(id: 0, name: 'Counter-Strike'),
    ];
  }
}
