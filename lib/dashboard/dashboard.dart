import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_store/add_product.dart';
import 'package:mini_store/category/show_product.dart';
import 'package:mini_store/dashboard/shopping_cart.dart';
import 'package:mini_store/data/categories.dart';

class Dashboard extends StatelessWidget {
  final bool mode;

  const Dashboard({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return mode ? editMode(context) : viewMode(context);
    });
  }

  Widget viewMode(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Card(
                  color: categories[index].color.withOpacity(0.5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(categories[index].products.length, (i) {
                        return SizedBox(
                          width: 150,
                          height: 150,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return ShowProduct(
                                    product: categories[index].products[i],
                                    category: categories[index],
                                  );
                                }));
                              },
                              child: LayoutBuilder(
                                builder: (contextCard, constraits) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: constraits.maxWidth,
                                            height: constraits.maxHeight / 1.5,
                                            child: Card(
                                              color: categories[index].color,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: categories[index]
                                                        .products[i]
                                                        .images
                                                        .isEmpty
                                                    ? Icon(
                                                        categories[index]
                                                            .products[i]
                                                            .icon,
                                                        size: constraits
                                                                .maxWidth /
                                                            4,
                                                        color: Colors.black
                                                            .withAlpha(90),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image(
                                                          image:
                                                              categories[index]
                                                                  .products[i]
                                                                  .images[0],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            categories[index].products[i].name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                        );
                      }),
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return const ShoppingCart();
            }));
          },
          child: const FaIcon(FontAwesomeIcons.cashRegister),
        ),
      ),
    );
  }

  Widget editMode(BuildContext context) {
    return Scaffold(
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) {
                return const AddProduct();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
