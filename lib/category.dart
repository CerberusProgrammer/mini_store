import 'package:flutter/material.dart';
import 'package:mini_store/data/categories.dart';

class Category extends StatelessWidget {
  final bool mode;

  const Category({
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
                  elevation: 5,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            categories[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        )
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
