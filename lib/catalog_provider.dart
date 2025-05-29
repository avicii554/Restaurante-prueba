import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product.dart';

class CatalogNotifier extends StateNotifier<List<Product>> {
  CatalogNotifier() : super([
    Product(id: '1', name: 'Hamburguesa', price: 8.0, category: Category.food),
    Product(id: '2', name: 'Refresco', price: 2.0, category: Category.drink),
    Product(id: '3', name: 'Pastel', price: 4.0, category: Category.dessert),
  ]);

  void add(Product p) => state = [...state, p];

  void update(Product p) =>
      state = [for (final prod in state) if (prod.id == p.id) p else prod];

  void remove(Product p) => state = state.where((e) => e.id != p.id).toList();
}

final catalogProvider =
    StateNotifierProvider<CatalogNotifier, List<Product>>((ref) => CatalogNotifier());
