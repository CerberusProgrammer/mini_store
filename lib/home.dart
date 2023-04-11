import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Store'),
      ),
      body: TabContainer(
        tabEdge: TabEdge.right,
        radius: 10,
        tabCurve: Curves.easeInOut,
        tabs: const [
          'Tab 1',
          'Tab 2',
          'Tab 3',
        ],
        colors: [
          Colors.indigo,
          Colors.indigo,
          Colors.indigo,
        ],
        children: List.generate(3, (index) {
          return Text('$index');
        }),
      ),
    );
  }
}
