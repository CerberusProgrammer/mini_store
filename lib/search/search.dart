import 'package:flutter/material.dart';

import '../object/category.dart';
import '../object/product.dart';

class Search extends StatefulWidget {
  final bool mode;
  final List<Product>? products;

  const Search({
    super.key,
    required this.mode,
    this.products,
  });

  static List<Product> getProductsInCategory(Category category) {
    return category.products;
  }

  @override
  State<StatefulWidget> createState() => _Search();
}

class _Search extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
