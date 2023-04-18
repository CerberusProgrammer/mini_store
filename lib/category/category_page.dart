import 'package:flutter/material.dart';
import 'package:mini_store/category/change_category.dart';
import 'package:mini_store/category/show_products.dart';
import 'package:mini_store/data/categories.dart';

class CategoryPage extends StatelessWidget {
  final bool mode;

  const CategoryPage({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return mode ? editMode() : viewMode();
  }

  Widget viewMode() {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: constraints.maxWidth > 800 ? 6 : 3,
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return Card(
                  color: categories[index].color.withAlpha(127),
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

  Widget editMode() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: constraints.maxWidth > 800 ? 6 : 3,
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return Card(
                  color: categories[index].color.withAlpha(127),
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
                      }));
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
              showDialog(
                  context: context,
                  builder: (builder) {
                    return const AlertDialog(
                      title: Text('Add new category'),
                    );
                  });
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
