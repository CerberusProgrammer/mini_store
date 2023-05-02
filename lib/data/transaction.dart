import 'package:mini_store/object/product.dart';

class Transaction {
  DateTime date;
  double money;
  List<Product> products;

  Transaction({
    required this.date,
    required this.money,
    required this.products,
  });
}
