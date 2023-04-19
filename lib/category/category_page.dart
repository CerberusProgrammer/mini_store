import 'package:flutter/material.dart';
import 'package:mini_store/category/change_category.dart';
import 'package:mini_store/category/create_category.dart';
import 'package:mini_store/category/show_products.dart';
import 'package:mini_store/data/categories.dart';

import 'create_category.dart';

class CategoryPage extends StatefulWidget {
  bool mode;

  CategoryPage({
    super.key,
    required this.mode,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final bool mode = widget.mode;
    return mode ? editMode(mode) : viewMode();
  }

  Widget viewMode() {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: constraints.maxWidth ~/ 150 > 0
                  ? constraints.maxWidth ~/ 150
                  : 1,
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return Card(
                  color: categories[index].color.withAlpha(180),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) {
                            return ShowProducts(
                              category: categories[index],
                            );
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Icon(
                            categories[index].icon,
                            color: const Color.fromARGB(79, 0, 0, 0),
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget editMode(bool mode) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: constraints.maxWidth ~/ 150 > 0
                  ? constraints.maxWidth ~/ 150
                  : 1,
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return Card(
                  color: categories[index].color.withAlpha(180),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return ChangeCategory(
                          index: index,
                        );
                      })).then((value) {
                        setState(() {
                          mode = true;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Icon(
                            categories[index].icon,
                            color: const Color.fromARGB(79, 0, 0, 0),
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return const CreateCategory();
              })).then((value) {
                setState(() {
                  mode = true;
                });
              });
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
