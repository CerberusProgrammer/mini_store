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
      headerExpandedHeight: .6,
      stretchMaxHeight: .8,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      appBarColor: widget.category.color,
      alwaysShowLeadingAndAction: true,
      alwaysShowTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      headerWidget: Container(
        color: widget.category.color,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Card(
            elevation: 10,
            color: widget.category.color,
            child: Icon(
              widget.category.icon,
              size: 100,
              color: const Color.fromARGB(180, 255, 255, 255),
            ),
          ),
        ),
      ),
      body: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                            fontSize: 32,
                            color: widget.category.color,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.category.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 15),
                child: Text(
                  widget.product.description.isEmpty
                      ? 'No description.'
                      : widget.product.description,
                ),
              ),
              Text(
                '\$${widget.product.price}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: widget.category.color,
                ),
              ),
            ],
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: widget.category.color,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
