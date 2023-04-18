import 'package:flutter/material.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/data/select_icons.dart';

import '../data/select_colors.dart';

class ChangeCategory extends StatefulWidget {
  final int index;

  const ChangeCategory({
    super.key,
    required this.index,
  });

  @override
  State<ChangeCategory> createState() => _ChangeCategoryState();
}

class _ChangeCategoryState extends State<ChangeCategory> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = categories[widget.index].name;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(categories[widget.index].name),
            actions: [
              IconButton(
                  onPressed: () {
                    BuildContext mainContext = context;
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            title: const Text('Delete category'),
                            content: const Text(
                                'You are going to delete this category with all the products contained.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel')),
                              FilledButton(
                                  onPressed: () {
                                    categories.removeAt(widget.index);
                                    Navigator.pop(context);
                                    Navigator.pop(mainContext);
                                  },
                                  child: const Text('Delete')),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: 300,
                    child: Card(
                      color: categories[widget.index].color,
                      elevation: 10,
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Icon(
                            categories[widget.index].icon,
                            size: 150,
                            color: const Color.fromARGB(79, 0, 0, 0),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        categories[widget.index].name = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: 125,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 8,
                          children:
                              List.generate(selectColorPlus.length, (index) {
                            return OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  categories[widget.index].color =
                                      selectColorPlus[index];
                                });
                              },
                              child: null,
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: selectColorPlus[index],
                                  side: const BorderSide(
                                      color: Color.fromARGB(70, 35, 35, 35),
                                      width: 8)),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: 150,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(selectIcons.length, (index) {
                            return OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  categories[widget.index].icon =
                                      selectIcons[index];
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  side: const BorderSide(
                                      color: Color.fromARGB(60, 35, 35, 35),
                                      width: 4)),
                              child: Icon(
                                selectIcons[index],
                                color: Colors.black,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.done),
          ),
        );
      },
    );
  }
}
