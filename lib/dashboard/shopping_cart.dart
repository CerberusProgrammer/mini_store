import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_store/dashboard/payment.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/category.dart';

import '../object/product.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int? chipValue;
  bool isSearching = false;
  List<Product> items = [];
  bool chipSearch = false;
  Category? category;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    Categories.initCategories();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(50),
        title: const Text('Cash Register'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return const Payment();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_forward,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  label: Text('Search'), icon: Icon(Icons.search)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text(
                          categories[index].name,
                          style: const TextStyle(
                              color: Color.fromARGB(240, 255, 255, 255)),
                        ),
                        selected: chipValue == index,
                        side: BorderSide.none,
                        selectedColor: categories[index].color,
                        backgroundColor: categories[index].color.withAlpha(128),
                        onSelected: (value) {
                          setState(() {
                            if (chipValue == chipValue) {
                              chipValue = null;
                            } else {
                              chipValue = (value ? index : null)!;
                            }

                            isSearching = true;
                            chipSearch = true;
                            category = categories[index];
                            items = categories[index].products;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            isSearching
                ? chipSearch
                    ? Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: category?.products.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        category?.color.withAlpha(180),
                                    child: Icon(category?.products[index].icon),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                  title: Text(
                                      category?.products[index].name ?? ''),
                                  subtitle: Text(
                                      '${category?.products[index].price}'),
                                  onTap: () {},
                                );
                              }),
                            ),
                          ),
                        ),
                      )
                    : const Center()
                : const Center(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const FaIcon(FontAwesomeIcons.barcode),
      ),
    );
  }
}
