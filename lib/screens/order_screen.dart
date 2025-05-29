import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cart_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: const Text('Tu Pedido')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cart.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final item = cart[i];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Text(
                    '\${(item.product.price * item.quantity).toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Total: \\${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Pedido realizado!')),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Confirmar Pedido'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
