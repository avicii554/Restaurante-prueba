enum Category { food, drink, dessert }

class Product {
  String id;
  String name;
  double price;
  Category category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });
}
