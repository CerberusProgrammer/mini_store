import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController description = TextEditingController();
  final TextEditingController name = TextEditingController();

  bool isCompleted = false;
  bool isOk = false;

  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> pages = [
      PageViewModel(
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
        ),
        title: 'Describe your product',
        bodyWidget: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                autofocus: true,
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (string) {
                  if (string.isNotEmpty) {
                    setState(() {
                      isCompleted = true;
                    });
                  } else {
                    setState(() {
                      isCompleted = false;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: SizedBox(
                  width: 300,
                  child: PopupMenuButton(
                    child: const ListTile(
                      title: Text('Select a category'),
                    ),
                    itemBuilder: (BuildContext context) {
                      return List.generate(2, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: Text('$index'),
                        );
                      });
                    },
                    onSelected: (value) {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      PageViewModel(
        title: 'Lets talk about money',
        body: 'How much',
      ),
      PageViewModel(
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
        ),
        title: 'e',
        body: 'e',
        footer: Center(
          child: Text(
            isOk ? 'ok' : 'not ok',
          ),
        ),
      ),
    ];

    return IntroductionScreen(
      pages: pages,
      showNextButton: isCompleted,
      showDoneButton: isOk,
      showSkipButton: true,
      skip: const Text('Cancel'),
      back: const Icon(Icons.arrow_back),
      done: isOk ? const Text('Done') : null,
      next: isCompleted
          ? const Icon(
              Icons.arrow_forward,
            )
          : null,
      onDone: () {
        Navigator.pop(context);
      },
      onSkip: () {
        name.clear();
        description.clear();
        Navigator.pop(context);
      },
    );
  }
}
