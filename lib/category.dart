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
          return GridView.count(
            crossAxisSpacing: 2,
            crossAxisCount: constraints.maxWidth > 800 ? 6 : 3,
            shrinkWrap: true,
            children: List.generate(10, (index) {
              return Card(
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {},
                  child: ListTile(
                    subtitle: Text('$index'),
                  ),
                ),
              );
            }),
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
