import 'package:flutter/material.dart';
import 'package:mini_store/dashboard/change.dart';
import 'package:mini_store/dashboard/payment_completed.dart';
import 'package:mini_store/object/category.dart';

import '../object/product.dart';

class Payment extends StatefulWidget {
  final List<Product> products;
  final double totalPayment;

  const Payment({
    super.key,
    required this.products,
    required this.totalPayment,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double payment = 0;

  @override
  void initState() {
    payment = widget.totalPayment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        ? Icon(
                            widget.products[index].icon,
                          )
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
                          if (widget.products[index].quantity > 0) {
                            setState(() {
                              widget.products[index].quantity--;
                              payment -= widget.products[index].price;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Chip(
                        side: BorderSide.none,
                        label: Text('${widget.products[index].quantity}'),
                      ),
                      IconButton(
                          onPressed: () {
                            if (widget.products[index].quantity <
                                widget.products[index].disponibility) {
                              setState(() {
                                widget.products[index].quantity++;
                                payment += widget.products[index].price;
                              });
                            }
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
        color: Theme.of(context).colorScheme.primary.withAlpha(160),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 5,
                child: InkWell(
                  borderRadius: BorderRadius.circular(11),
                  onTap: () {
                    if (widget.products.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return Change(
                              products: widget.products,
                              total: payment,
                            );
                          }).then((value) {
                        if (value != null) {
                          if (value > 0) {
                            showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  title: const Text('Change'),
                                  content: Row(
                                    children: [
                                      const Text(
                                        'Return ',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '\$${(value as double).toStringAsFixed(2)} USD',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')),
                                    FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: ((context, animation,
                                                  secondaryAnimation) {
                                                return PaymentCompleted(
                                                  products: widget.products,
                                                  payment: widget.totalPayment,
                                                );
                                              }),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin =
                                                    const Offset(0.0, 1.0);
                                                var end = Offset.zero;
                                                var curve = Curves.ease;

                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));

                                                return SlideTransition(
                                                  position:
                                                      animation.drive(tween),
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text('Complete'))
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    ((context, animation, secondaryAnimation) {
                                  return PaymentCompleted(
                                    products: widget.products,
                                    payment: widget.totalPayment,
                                  );
                                }),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          }
                        }
                      });
                    }
/*
                    if (widget.products.isNotEmpty) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) {
                            return Change(
                              products: widget.products,
                              total: widget.totalPayment,
                            );
                          }),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                    */
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Total: \$$payment',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
