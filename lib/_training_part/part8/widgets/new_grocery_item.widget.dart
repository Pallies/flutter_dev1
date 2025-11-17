import 'dart:convert';

import 'package:first_app/_training_part/part8/providers/category.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.model.dart';
import 'package:http/http.dart' as http;

import '../models/grocery_item.model.dart';

class NewGroceryItem extends ConsumerStatefulWidget {
  const NewGroceryItem({super.key});

  @override
  ConsumerState<NewGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends ConsumerState<NewGroceryItem> {
  //pour l'utilisation des validateurs mais peut être dans le provider
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  var _enteredName = '';
  var _enteredQuantity = 1;
  late Category _selectedCategory = categoriesList[Categories.vegetables]!;
  late final Map<Categories, Category> categoriesList;

  void _savedGroceryItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
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

      // context.mounted propriété qui indique si le widget associé au BuildContext est toujours "monté" dans l'arbre des widgets.
      if (!context.mounted) {
        return;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        Navigator.of(context).pop(
          GroceryItem(
            id: result['name'],
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory,
          ),
        );
      }else if(response.statusCode>=400){
        setState(() {
          _isSubmitting = false;
        });
        // Gérer les erreurs de soumission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add item. Please try again.')),
        );
      }
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
                  TextButton(
                    onPressed: () => _isSubmitting ? null : _formKey.currentState!.reset(),
                    child: Text('Reset'),
                  ), //disable le bouton si en train de soumettre
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _savedGroceryItem,
                    //disable le bouton si en train de soumettre
                    child: _isSubmitting
                        ? SizedBox(height: 16, width: 16, child: CircularProgressIndicator())
                        : Text('Validez'),
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
