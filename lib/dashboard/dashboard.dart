import 'package:flutter/material.dart';
import 'package:mini_store/dashboard/add_product.dart';

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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: constraints.maxWidth,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (itemBuilder, index) {
                    return Text('$index');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editMode(BuildContext context) {
    return Scaffold(
      body: Text('edit'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return const AddProduct();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
