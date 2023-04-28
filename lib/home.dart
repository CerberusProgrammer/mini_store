import 'package:flutter/material.dart';
import 'package:mini_store/category/category_page.dart';
import 'package:mini_store/dashboard/dashboard.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/profile/profile.dart';
import 'package:mini_store/stats/stats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  bool mode = false;

  static List<Tab> tabs = const [
    Tab(
      icon: Icon(Icons.home),
      text: 'Home',
    ),
    Tab(
      icon: Icon(Icons.category),
      text: 'Category',
    ),
    Tab(
      icon: Icon(Icons.bar_chart),
      text: 'Stadistics',
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
    Categories.initCategories();
    controller = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          CategoryPage(mode: mode),
          const Stats(),
          Profile(mode: mode),
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
