import 'package:flutter/material.dart';
import 'admin_edit_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../catalog_provider.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(catalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar Productos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AdminEditScreen())),
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final p = products[i];
          return ListTile(
            title: Text(p.name),
            subtitle: Text('\${p.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdminEditScreen(product: p),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      ref.read(catalogProvider.notifier).remove(p),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
