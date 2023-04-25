import 'package:flutter/material.dart';

import '../object/product.dart';

class Payment extends StatefulWidget {
  final List<Product> products;

  const Payment({
    super.key,
    required this.products,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double totalPayment = 0;

  @override
  Widget build(BuildContext context) {
    for (Product product in widget.products) {
      totalPayment += product.price * product.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: ListView.builder(
              itemCount: widget.products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        widget.products[index].color.withAlpha(128),
                    child: widget.products[index].images.isEmpty
                        ? Icon(widget.products[index].icon)
                        : Image(
                            image: widget.products[index].images[0],
                          ),
                  ),
                  trailing: Chip(
                    side: BorderSide.none,
                    label: Text(
                      '\$${widget.products[index].price * widget.products[index].quantity}',
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.products[index].quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Chip(
                        side: BorderSide.none,
                        label: Text('${widget.products[index].quantity}'),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.products[index].quantity++;
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  onTap: () {},
                  title: Text(widget.products[index].name),
                );
              }),
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary.withAlpha(50),
        height: 60,
        child: Row(
          children: [Chip(label: Text('Total: $totalPayment'))],
        ),
      ),
    );
  }
}
