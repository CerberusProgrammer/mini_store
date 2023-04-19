class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    this.price = 0,
    this.disponibility = 0,
  });
}
