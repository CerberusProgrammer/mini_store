import 'package:flutter/material.dart';
import 'package:mini_store/stats/daily.dart';
import 'package:mini_store/stats/monthly.dart';
import 'package:mini_store/stats/weekly.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<StatefulWidget> createState() => _Stats();
}

class _Stats extends State<Stats> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<String> titles = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

  int _currentIndex = 1;

  void _onLeftArrowTap() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onRightArrowTap() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _onLeftArrowTap();
                },
              )
            : const Center(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _currentIndex < 2
                ? IconButton(
                    onPressed: () {
                      _onRightArrowTap();
                    },
                    icon: const Icon(Icons.arrow_forward),
                  )
                : const Center(),
          )
        ],
        centerTitle: true,
        title: Text(
          titles[_currentIndex],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Daily(),
          Weekly(),
          Monthly(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
