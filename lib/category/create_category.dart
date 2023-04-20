import 'package:flutter/material.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/data/select_colors.dart';
import 'package:mini_store/object/category.dart';

import '../data/select_icons.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<StatefulWidget> createState() => _CreateCategory();
}

class _CreateCategory extends State<CreateCategory> {
  String title = '';
  bool existsTitle = false;
  IconData icon = Icons.store;
  Color color = Colors.blue;
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: 300,
                  child: Card(
                    color: color,
                    elevation: 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Icon(
                          icon,
                          size: 150,
                          color: const Color.fromARGB(79, 0, 0, 0),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              existsTitle = true;
                              title = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 10),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount:
                                    ((constraints.maxWidth ~/ 100) * 1.5)
                                        .toInt(),
                                children: List.generate(selectColorPlus.length,
                                    (index) {
                                  return OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        color = selectColorPlus[index];
                                      });
                                    },
                                    child: null,
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: selectColorPlus[index],
                                        side: const BorderSide(
                                            color:
                                                Color.fromARGB(70, 35, 35, 35),
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
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount:
                                    ((constraints.maxWidth ~/ 100) * 1.5)
                                        .toInt(),
                                children:
                                    List.generate(selectIcons.length, (index) {
                                  return OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        icon = selectIcons[index];
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        side: const BorderSide(
                                            color:
                                                Color.fromARGB(60, 35, 35, 35),
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: existsTitle
            ? FloatingActionButton(
                onPressed: () {
                  categories.add(Category(
                    name: title,
                    icon: icon,
                    color: color,
                  ));

                  Navigator.pop(context);
                },
                child: const Icon(Icons.done),
              )
            : null,
      );
    });
  }
}
