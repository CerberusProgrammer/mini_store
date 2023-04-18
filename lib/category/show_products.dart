import 'package:flutter/material.dart';
import 'package:mini_store/object/category.dart';

import '../add_product.dart';

class ShowProducts extends StatefulWidget {
  final Category category;

  const ShowProducts({
    super.key,
    required this.category,
  });

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  bool mode = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            actions: [
              Row(
                children: [
                  Icon(mode ? Icons.edit : Icons.visibility),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      value: mode,
                      onChanged: (bool newValue) {
                        setState(() {
                          mode = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: 200,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: widget.category.image!,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: mode
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) {
                          return AddProduct(
                            category: widget.category,
                          );
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.search),
                ),
        );
      },
    );
  }
}
