import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/category/carousel_product.dart';
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
  bool mode = false;

  Widget viewMode() {
    return Padding(
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
          Text('${widget.product.disponibility} avaible.'),
        ],
      ),
    );
  }

  Widget editMode() {
    return const Text('editi');
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      headerExpandedHeight: .58,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              widget.category.products.remove(widget.product);

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ],
      title: const Center(),
      backgroundColor: Colors.white,
      headerWidget: Container(
        color: widget.category.color,
        child: CarouselProduct(
          category: widget.category,
          product: widget.product,
        ),
      ),
      body: [mode ? editMode() : viewMode()],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mode = !mode;
          });
        },
        backgroundColor: widget.category.color,
        foregroundColor: Colors.white,
        child: Icon(mode ? Icons.done : Icons.edit),
      ),
    );
  }
}
