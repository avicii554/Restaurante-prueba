import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product.dart';

class CatalogNotifier extends StateNotifier<List<Product>> {
  CatalogNotifier() : super([
    Product(
      id: '1', 
      name: 'Hamburguesa', 
      price: 8.000, 
      category: Category.food,
      imageUrl: 'assets/burger.png',
    ),
    Product(
      id: '2', 
      name: 'Refresco', 
      price: 2.000, 
      category: Category.drink,
      imageUrl: 'assets/drink.png',
    ),
    Product(
      id: '3', 
      name: 'Pastel', 
      price: 3.500, 
      category: Category.dessert,
      imageUrl: 'assets/cake.png',
    ),
  ]);

  void add(Product p) => state = [...state, p];

  void update(Product p) =>
      state = [for (final prod in state) if (prod.id == p.id) p else prod];

  void remove(Product p) => state = state.where((e) => e.id != p.id).toList();
}

final catalogProvider =
    StateNotifierProvider<CatalogNotifier, List<Product>>((ref) => CatalogNotifier());