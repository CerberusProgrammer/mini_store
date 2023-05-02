import 'package:mini_store/data/money.dart';

class Business {
  String name;
  String description;
  String address;
  String phoneNumber;
  String email;
  int category;
  List<String> categoryList = [];
  List<Money> moneyList = [];

  Business({
    required this.name,
    this.description = '',
    this.address = '',
    this.phoneNumber = '',
    this.email = '',
    this.category = 0,
  });
}
