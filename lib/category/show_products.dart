import 'package:flutter/material.dart';
import 'package:mini_store/category/show_product.dart';
import 'package:mini_store/category/table.dart';
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
            surfaceTintColor: widget.category.color,
            shadowColor: widget.category.color,
            title: Text(widget.category.name),
            actions: [
              Row(
                children: [
                  Icon(mode ? Icons.edit : Icons.visibility),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      activeColor: widget.category.color,
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: 200,
                    child: Card(
                      color: widget.category.color,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 3,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                  ),
                  child: widget.category.products.isEmpty
                      ? const Center()
                      : Card(
                          color: widget.category.color.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: constraints.maxWidth ~/ 150 > 0
                                  ? constraints.maxWidth ~/ 150
                                  : 1,
                              shrinkWrap: true,
                              children: List.generate(
                                widget.category.products.length,
                                (index) {
                                  return LayoutBuilder(
                                    builder: (miniContext, miniConstraints) {
                                      return Card(
                                        color: Colors.white,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: mode
                                              ? null
                                              : () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (builder) {
                                                    return ShowProduct(
                                                      product: widget.category
                                                          .products[index],
                                                      category: widget.category,
                                                    );
                                                  })).then((value) {
                                                    setState(() {
                                                      mode = mode;
                                                    });
                                                  });
                                                },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: miniConstraints.maxWidth,
                                                height:
                                                    miniConstraints.maxHeight /
                                                        2.2,
                                                child: Card(
                                                  color: widget.category.color,
                                                  child: widget
                                                          .category
                                                          .products[index]
                                                          .images
                                                          .isEmpty
                                                      ? Icon(
                                                          widget
                                                              .category
                                                              .products[index]
                                                              .icon,
                                                          color: Colors.black
                                                              .withAlpha(90),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image(
                                                            image: widget
                                                                .category
                                                                .products[index]
                                                                .images[0],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 8.0),
                                                child: Text(
                                                  widget.category
                                                      .products[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Row(
                                                  children: [
                                                    mode
                                                        ? IconButton(
                                                            onPressed: () {},
                                                            style: TextButton.styleFrom(
                                                                foregroundColor:
                                                                    widget
                                                                        .category
                                                                        .color),
                                                            icon: const Icon(
                                                                Icons.edit),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              '\$${widget.category.products[index].price}',
                                                              style: TextStyle(
                                                                color: widget
                                                                    .category
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                    const Spacer(),
                                                    mode
                                                        ? IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                widget.category
                                                                    .products
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                            },
                                                            style: TextButton.styleFrom(
                                                                foregroundColor:
                                                                    widget
                                                                        .category
                                                                        .color),
                                                            icon: const Icon(
                                                                Icons.delete),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              '${widget.category.products[index].disponibility}',
                                                              style: TextStyle(
                                                                color: widget
                                                                    .category
                                                                    .color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: mode
              ? FloatingActionButton(
                  backgroundColor: widget.category.color,
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
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              : FloatingActionButton(
                  backgroundColor: widget.category.color,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(widget.category.name),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 1,
                              child: ShowTable(
                                category: widget.category,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                  child: const Icon(
                    Icons.table_chart,
                    color: Colors.white,
                  ),
                ),
        );
      },
    );
  }
}
