import 'package:flutter/material.dart';

import '../object/product.dart';

class Change extends StatefulWidget {
  final List<Product> products;
  final double total;

  const Change({
    super.key,
    required this.products,
    required this.total,
  });

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  TextEditingController money = TextEditingController();
  double pending = 0;
  bool done = false;

  @override
  void initState() {
    pending = widget.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Money Received'),
      content: TextField(
        controller: money,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefix: const Text('\$'),
            suffix: const Text('USD'),
            errorText: done ? null : '\$$pending USD pending.'),
        onSubmitted: (value) {
          double d = double.parse(money.text);

          if (d < pending) {
            setState(() {
              pending = (d - widget.total).abs();
            });
          } else {
            setState(() {
              pending = 0;
              done = true;
            });
          }

          if (done) {
            if (money.text.isNotEmpty) {
              double d = double.parse(money.text);
              double result = d - widget.total;
              Navigator.of(context).pop(result.abs());
            }
          }
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('Cancel')),
        FilledButton(
            onPressed: done
                ? () {
                    if (money.text.isNotEmpty) {
                      double d = double.parse(money.text);
                      double result = d - widget.total;
                      Navigator.of(context).pop(result.abs());
                    }
                  }
                : null,
            child: const Text('Done')),
      ],
    );
  }
}
