import 'dart:ui';

import 'package:flutter/material.dart';

import '../object/product.dart';

class Payment extends StatelessWidget {
  final List<Product> products;

  const Payment({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
        );
      }),
    );
  }
}
