import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_store/add_product.dart';
import 'package:mini_store/dashboard/shopping_cart.dart';

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
