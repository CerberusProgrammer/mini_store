class Business {
  String name;
  String description;
  String address;
  String phoneNumber;
  String email;
  int category;
  List<String> categoryList = [];

  Business({
    required this.name,
    this.description = '',
    this.address = '',
    this.phoneNumber = '',
    this.email = '',
    this.category = 0,
  });

  @override
  String toString() {
    return '';
  }
}
