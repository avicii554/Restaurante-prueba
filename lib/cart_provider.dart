import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem(this.product, this.quantity);
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product p, int qty) {
    final idx = state.indexWhere((e) => e.product.id == p.id);
    if (idx == -1) {
      state = [...state, CartItem(p, qty)];
    } else {
      final items = [...state];
      items[idx].quantity += qty;
      state = items;
    }
  }

  void update(Product p, int qty) {
    final items = [...state];
    final idx = items.indexWhere((e) => e.product.id == p.id);
    if (idx != -1) items[idx].quantity = qty;
    state = items;
  }

  void remove(Product p) =>
      state = state.where((e) => e.product.id != p.id).toList();

  double get total =>
      state.fold(0, (sum, e) => sum + e.product.price * e.quantity);

  void clear() => state = [];
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
