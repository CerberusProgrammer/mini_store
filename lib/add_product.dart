import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mini_store/data/currency.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/product.dart';

class AddProduct extends StatefulWidget {
  final Category? category;

  const AddProduct({
    super.key,
    this.category,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController description = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController disponibility = TextEditingController();

  bool isCompleted = false;
  bool isOk = false;
  int category = -1;
  String currency = "USD";

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
                onSubmitted: (value) {
                  setState(() {
                    name.text = value;
                  });
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
                    labelText: 'Description (optional)',
                  ),
                ),
              ),
            ),
            widget.category == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: const Text('Select a category'),
                          value: category >= 0 ? category : null,
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          onChanged: (value) {
                            setState(() {
                              category = value ?? 0;
                            });
                          },
                          items: List.generate(categories.length, (index) {
                            return DropdownMenuItem<int>(
                                value: index,
                                child: Text(categories[index].name));
                          }),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        title: Text(widget.category!.name),
                      ),
                    ),
                  ),
            SizedBox(
              width: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: price,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(currency)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 40,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          value: currency,
                          onChanged: (value) {
                            setState(() {
                              currency = value ?? 'USD';
                            });
                          },
                          items: List.generate(currencies.length, (index) {
                            return DropdownMenuItem<String>(
                                value: currencies[index],
                                child: Text(currencies[index]));
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: disponibility,
                  decoration: const InputDecoration(
                    labelText: 'Disponibility',
                  ),
                ),
              ),
            ),
          ],
        ),
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
      showNextButton:
          (name.text.isNotEmpty && (category >= 0 || widget.category != null)),
      showDoneButton:
          (name.text.isNotEmpty && (category >= 0 || widget.category != null)),
      showSkipButton: true,
      skip: const Text('Cancel'),
      back: const Icon(Icons.arrow_back),
      done: (name.text.isNotEmpty && (category >= 0 || widget.category != null))
          ? const Text('Done')
          : null,
      next: (name.text.isNotEmpty && (category >= 0 || widget.category != null))
          ? const Icon(
              Icons.arrow_forward,
            )
          : null,
      onDone: () {
        if (category >= -1) {}

        widget.category?.products.add(Product(
          id: widget.category!.products.length,
          name: name.text,
          category: category == -1 ? widget.category! : categories[category],
        ));

        Navigator.pop(context);
      },
      onSkip: () {
        name.clear();
        description.clear();
        price.clear();
        disponibility.clear();
        Navigator.pop(context);
      },
    );
  }
}
