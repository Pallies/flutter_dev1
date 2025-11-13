import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../models/category.model.dart';
import '../providers/grocery_forms.provider.dart';

class NewGroceryItemRiverpod extends ConsumerStatefulWidget {
  const NewGroceryItemRiverpod({super.key});

  @override
  ConsumerState<NewGroceryItemRiverpod> createState() => _NewGroceryItemRiverpodState();
}

class _NewGroceryItemRiverpodState extends ConsumerState<NewGroceryItemRiverpod> {
  @override
  Widget build(BuildContext context) {
    final formNotifier = ref.read(groceryFormProvider.notifier);
    final formState = ref.watch(groceryFormProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Grocery Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: ref.watch(nameControllerProvider),
              maxLength: 50,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value)=>formNotifier.updateName(value),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ref.watch(quantityControllerProvider),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => formNotifier.updateQuantity(int.parse(value)),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: DropdownButtonFormField<Category>(
                    alignment: AlignmentGeometry.center,
                    initialValue: formState.category,
                    items: categories.entries.map((entry) {
                      final category = entry.value;
                      return DropdownMenuItem(
                        value: category,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(width: 16, height: 16, color: category.color),
                                const SizedBox(width: 26),
                                Text(category.title),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) formNotifier.updateCategory(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    print(
                      'Item: ${formState.name}, Qty: ${formState.quantity}, Cat: ${formState.category.title}',
                    );
                    formNotifier.clear();
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formNotifier.isValid()) {
                      print(
                        'Item: ${formState.name}, Qty: ${formState.quantity}, Cat: ${formState.category.title}',
                      );
                      Navigator.of(context).pop(formNotifier.formGroceryItem);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Formulaire invalide')),
                      );
                    }
                  },
                  child: const Text('Validez'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
