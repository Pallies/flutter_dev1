import 'dart:convert';

import 'package:first_app/_training_part/part8/models/grocery_item.model.dart';
import 'package:first_app/_training_part/part8/providers/category.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.model.dart';
import 'package:http/http.dart' as http;

class NewGroceryItem extends ConsumerStatefulWidget {
  const NewGroceryItem({super.key});

  @override
  ConsumerState<NewGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends ConsumerState<NewGroceryItem> {
  //pour l'utilisation des validateurs mais peut être dans le provider
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  late Category _selectedCategory = categoriesList[Categories.vegetables]!;
  late final Map<Categories, Category> categoriesList;

  void _savedGroceryItem() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.https('your-backend-endpoint.com', '/grocery-items.json');
      final response = await http.post(
        // Uri.parse('https://your-backend-endpoint.com/grocery-items.json'),
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.title,
        }),
      );
      _formKey.currentState!.save();
      // Navigator.of(context).pop(
      //   GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: _enteredName,
      //     quantity: _enteredQuantity,
      //     category: _selectedCategory,
      //   ),
      // );
      response.statusCode;
      // context.mounted propriété qui indique si le widget associé au BuildContext est toujours "monté" dans l'arbre des widgets.
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    categoriesList = ref.read(categoriesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Grocery Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Doit être une chaine de caractères';
                  }
                  return null;
                },
                onSaved: (value) => _enteredName = value!.trim(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(label: Text('Quantity')),
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Doit être un nombre valide';
                        }
                        return null;
                      },
                      onSaved: (value) => _enteredQuantity = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _selectedCategory,
                      items: [
                        ...categoriesList.entries.map((category) {
                          return DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(width: 16, height: 16, color: category.value.color),
                                const SizedBox(width: 6),
                                Text(category.value.title),
                              ],
                            ),
                          );
                        }),
                      ],
                      onChanged: (value) => _selectedCategory = value!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => _formKey.currentState!.reset(), child: Text('Reset')),
                  ElevatedButton(
                    onPressed: _savedGroceryItem,
                    child: Text('Validez'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
