import 'package:flutter/material.dart';
import 'package:mini_store/category/show_table.dart';
import 'package:mini_store/object/category.dart';

import '../add_product.dart';
import '../object/product.dart';

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
                    color: widget.category.color,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Icon(
                          widget.category.icon,
                          size: 100,
                          color: const Color.fromARGB(79, 0, 0, 0),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 1,
                      child: ProductDataGrid(
                        products: [
                          Product(
                              id: 0,
                              name: 'Product 1',
                              description: 'Description for product 1',
                              price: 23.45,
                              disponibility: 10),
                          Product(
                              id: 1,
                              name: 'Product 2',
                              description: 'Description for product 2',
                              price: 56.78,
                              disponibility: 20),
                          Product(
                              id: 2,
                              name: 'Product 3',
                              description: 'Description for product 3',
                              price: 12.34,
                              disponibility: 30),
                          Product(
                              id: 3,
                              name: 'Product 4',
                              description: 'Description for product 4',
                              price: 67.89,
                              disponibility: 40),
                          Product(
                              id: 4,
                              name: 'Product 5',
                              description: 'Description for product 5',
                              price: 45.67,
                              disponibility: 50),
                          Product(
                              id: 5,
                              name: 'Product 6',
                              description: 'Description for product 6',
                              price: 89.01,
                              disponibility: 60),
                          Product(
                              id: 6,
                              name: 'Product 7',
                              description: 'Description for product 7',
                              price: 34.56,
                              disponibility: 70),
                          Product(
                              id: 7,
                              name: 'Product 8',
                              description: 'Description for product 8',
                              price: 78.90,
                              disponibility: 80),
                        ],
                      ),
                    ),
                  )
                ],
              )
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
                    ).then((value) {
                      setState(() {
                        mode = mode;
                      });
                    });
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
