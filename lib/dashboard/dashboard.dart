import 'package:flutter/material.dart';
import 'package:mini_store/add_product.dart';

class Dashboard extends StatelessWidget {
  final bool mode;

  const Dashboard({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return mode ? editMode(context) : viewMode(constraints);
    });
  }

  Widget viewMode(BoxConstraints constraints) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
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
