import 'dart:convert';

import 'package:first_app/_training_part/part8/providers/grocery.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/categories.dart';
import '../models/grocery_item.model.dart';
import 'package:http/http.dart' as http;

import 'new_grocery_item.widget.dart';

class GroceryFutureList extends ConsumerStatefulWidget {
  const GroceryFutureList({super.key});

  @override
  ConsumerState<GroceryFutureList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryFutureList> {
  late List<GroceryItem> _groceryItems;
  late Future<List<GroceryItem>> _groceryLoadedItems;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _groceryLoadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https('your-backend-endpoint.com', '/grocery-items.json');

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to load grocery items');
    }
    if (response.body == 'null') {
      return [];
    } else {
      // final Map<String, Map<String, dynamic>> items = json.decode(response.body); // génère une erreur de type
      final Map<String, dynamic> items = json.decode(response.body);
      setState(() {
        _groceryItems = items.entries.map((el) {
          final category = categories.entries
              .firstWhere((catEl) => catEl.value.title == el.value['category'])
              .value;
          return GroceryItem(
            id: el.key,
            name: el.value['name'],
            quantity: el.value['quantity'],
            category: category,
          );
        }).toList();
      });
    }

    return _groceryItems;
  }

  void navigationToNewGroceryItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (context) => const NewGroceryItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final itemIndex = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.removeWhere((item) => item.id == item.id);
    });
    final url = Uri.https('your-backend-endpoint.com', '/grocery-items/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(itemIndex, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Item'),
        actions: [
          IconButton(
            onPressed: () => navigationToNewGroceryItem(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder( // permet de gérer les états d'une future est surtout utiliser pour un état initial mais non modifiable
        future: _groceryLoadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          if (snapshot.data!.isNotEmpty) {
            _groceryItems= snapshot.data!;
            return ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red.shade600,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white, size: 40),
                ),
                onDismissed: (direction) {
                  _removeItem(_groceryItems[index]);
                },
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart, size: 120, color: Colors.grey.shade400),
                const SizedBox(height: 20),
                Text(
                  'No items added yet!',
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
