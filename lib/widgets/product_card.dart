import 'package:flutter/material.dart';
import '../product.dart';
import 'quantity_selector.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final void Function(int qty) onAdd;
  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Icon(Icons.fastfood, size: 48)),
            Text(widget.product.name),
            Text('\${widget.product.price.toStringAsFixed(2)}'),
            QuantitySelector(
              quantity: qty,
              onChanged: (v) => setState(() => qty = v),
            ),
            ElevatedButton(
              onPressed: () => widget.onAdd(qty),
              child: const Text('Agregar'),
            )
          ],
        ),
      ),
    );
  }
}
