import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/object/product.dart';

class ShowProduct extends StatefulWidget {
  final Category category;
  final Product product;

  const ShowProduct({
    super.key,
    required this.product,
    required this.category,
  });

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text(widget.category.name),
      headerWidget: Container(
        color: widget.category.color,
        child: Center(
          child: Text('hi'),
        ),
      ),
      body: List.generate(10, (index) => Text('data')),
    );
  }
}
