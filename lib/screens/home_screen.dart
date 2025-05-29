import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../catalog_provider.dart';
import '../cart_provider.dart';
import '../widgets/product_card.dart';
import '../product.dart';
import 'order_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(catalogProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante Simple'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OrderScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AdminScreen())),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: [
          for (final p in products)
            ProductCard(
              product: p,
              onAdd: (qty) =>
                  ref.read(cartProvider.notifier).add(p, qty),
            )
        ],
      ),
    );
  }
}
