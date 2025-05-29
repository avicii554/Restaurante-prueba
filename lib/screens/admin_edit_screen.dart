import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../catalog_provider.dart';
import '../product.dart';

class AdminEditScreen extends ConsumerStatefulWidget {
  final Product? product;
  const AdminEditScreen({super.key, this.product});

  @override
  ConsumerState<AdminEditScreen> createState() => _AdminEditScreenState();
}

class _AdminEditScreenState extends ConsumerState<AdminEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late double price;
  late Category category;

  @override
  void initState() {
    super.initState();
    name = widget.product?.name ?? '';
    price = widget.product?.price ?? 0;
    category = widget.product?.category ?? Category.food;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.product == null ? 'Agregar' : 'Editar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (v) => name = v ?? '',
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                initialValue: price == 0 ? '' : price.toString(),
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                onSaved: (v) => price = double.tryParse(v ?? '') ?? 0,
                validator: (v) =>
                    v == null || double.tryParse(v) == null ? 'Inválido' : null,
              ),
              DropdownButtonFormField<Category>(
                value: category,
                items: Category.values
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (v) => setState(() => category = v!),
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final notifier = ref.read(catalogProvider.notifier);
                    if (widget.product == null) {
                      notifier.add(Product(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: name,
                          price: price,
                          category: category));
                    } else {
                      notifier.update(Product(
                          id: widget.product!.id,
                          name: name,
                          price: price,
                          category: category));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.product == null ? 'Agregar' : 'Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
