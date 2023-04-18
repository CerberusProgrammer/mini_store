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
          appBar: AppBar(
            title: Text(categories[widget.index].name),
          ),
          body: Column(
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
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 8,
                        children: List.generate(selectColor.length, (index) {
                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                categories[widget.index].color =
                                    selectColor[index];
                              });
                            },
                            child: null,
                            style: OutlinedButton.styleFrom(
                                backgroundColor: selectColor[index],
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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 8,
                        children: List.generate(selectIcons.length, (index) {
                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                categories[widget.index].icon =
                                    selectIcons[index];
                              });
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                side: const BorderSide(
                                    color: Color.fromARGB(70, 35, 35, 35),
                                    width: 8)),
                            child: Icon(selectIcons[index]),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
/*

AlertDialog(
                              title: Text(categories[index].name),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth / 2.6,
                                    height: 60,
                                    child: TextField(
                                      controller: name,
                                      decoration: const InputDecoration(
                                          labelText: 'Name'),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        categories[index].icon,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 40,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                categories[index].color,
                                            side: const BorderSide(
                                                color: Color.fromARGB(
                                                    70, 35, 35, 35),
                                                width: 8)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (builder) {
                                                return ChangeColor(
                                                  index: index,
                                                );
                                              });
                                        },
                                        child: null),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                FilledButton(
                                    onPressed: () {
                                      categories[index].name = name.text;
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Change')),
                              ],
                            );

*/
