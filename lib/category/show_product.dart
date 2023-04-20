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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.category.color,
        actions: [],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Container(
              color: widget.category.color,
            ),
          ),
          Card()
        ],
      ),
    );
  }
}

/*
DraggableHome(
                                                appBarColor:
                                                    widget.category.color,
                                                alwaysShowLeadingAndAction:
                                                    true,
                                                title: Text(widget.category
                                                    .products[index].name),
                                                backgroundColor: Colors.white,
                                                headerWidget: Container(
                                                  color: widget.category.color,
                                                  child: Icon(
                                                    widget.category.icon,
                                                    size: 100,
                                                  ),
                                                ),
                                                body: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        widget
                                                            .category
                                                            .products[index]
                                                            .name,
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
 */