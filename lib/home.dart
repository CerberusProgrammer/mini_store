import 'package:flutter/material.dart';
import 'package:mini_store/category.dart';
import 'package:mini_store/dashboard/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  bool mode = false;

  static const List<Tab> tabs = [
    Tab(
      icon: Icon(Icons.home),
      text: 'Home',
    ),
    Tab(
      icon: Icon(Icons.category),
      text: 'Category',
    ),
    Tab(
      icon: Icon(Icons.person),
      text: 'Profile',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome, User'),
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
      body: TabBarView(
        controller: controller,
        children: [
          Dashboard(mode: mode),
          Category(mode: mode),
          const Center(),
        ],
      ),
      bottomNavigationBar: Material(
          child: TabBar(
        tabs: tabs,
        controller: controller,
      )),
    );
  }
}
