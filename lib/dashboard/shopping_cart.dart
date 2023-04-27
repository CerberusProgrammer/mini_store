import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_store/dashboard/payment.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/category.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
  List<Product> shoppingList = [];
  bool chipSearch = false;
  Category? category;
  bool selected = false;

  String barCode = "";

  @override
  Widget build(BuildContext context) {
    Categories.initCategories();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cash Register'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            bottom: 8,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await Permission.camera.request().isGranted) {
                        String? codeSanner = await scanner.scan();

                        setState(() {
                          barCode = codeSanner ?? "";
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.barcode_reader,
                    ),
                  ),
                ],
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
                          backgroundColor:
                              categories[index].color.withAlpha(128),
                          onSelected: (value) {
                            setState(() {
                              chipValue = (value ? index : null)!;

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
                                      child:
                                          Icon(category?.products[index].icon),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        for (int i = 0;
                                            i < shoppingList.length;
                                            i++) {
                                          if (shoppingList[i].id ==
                                              category!.products[index].id) {
                                            if (shoppingList[i].quantity <
                                                shoppingList[i].disponibility) {
                                              setState(() {
                                                shoppingList[i].quantity =
                                                    shoppingList[i].quantity +
                                                        1;
                                              });
                                            }

                                            return;
                                          }
                                        }

                                        Product product =
                                            category!.products[index];
                                        product.quantity = 1;
                                        setState(() {
                                          shoppingList.add(product);
                                        });
                                      },
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
          onPressed: () {
            double payment = 0;
            for (int i = 0; i < shoppingList.length; i++) {
              payment += shoppingList[i].price * shoppingList[i].quantity;
            }

            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return Payment(
                products: shoppingList,
                totalPayment: payment,
              );
            }));
          },
          child: shoppingList.isEmpty
              ? const FaIcon(
                  FontAwesomeIcons.cartShopping,
                )
              : Badge(
                  label: Text(shoppingList.length > 99
                      ? '99+'
                      : '${shoppingList.length}'),
                  child: const FaIcon(
                    FontAwesomeIcons.cartShopping,
                  ),
                ),
        ),
      ),
    );
  }
}
