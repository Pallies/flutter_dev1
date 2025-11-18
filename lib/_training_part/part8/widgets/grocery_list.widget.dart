import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/categories.dart';
import '../models/grocery_item.model.dart';
import 'package:http/http.dart' as http;

import 'new_grocery_item.widget.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  late List<GroceryItem> _groceryItems;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('your-backend-endpoint.com', '/grocery-items.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to add item. Please try again.';
        });
      } else {
        if (response.body == 'null') {
          setState(() {
            _groceryItems = [];
            _isLoading = false;
          });
          return;
        }
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
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch data items. Please try again later.';
      });
    }
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
      _isLoading = false;
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
    Widget noContent = Center(
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

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery Item'),
        ),
        body: Center(
          child: Text('An error occurred: $_errorMessage'),
        ),
      );
    }
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
      //  ListView.builder Pour les grandes listes ou dynamiques
      // ListView(children: [...]) — Pour les petites listes statiques
      body: _groceryItems.isNotEmpty
          ? ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                // Définir les directions possibles
                // direction: DismissDirection.horizontal,
                //
                // // Background quand on glisse vers la droite (Archive)
                // background: Container(
                //   color: Colors.blue,
                //   alignment: Alignment.centerLeft,
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: const Icon(Icons.archive, color: Colors.white),
                // ),
                //
                // // Background quand on glisse vers la gauche (Supprimer)
                // secondaryBackground: Container(
                //   color: Colors.red,
                //   alignment: Alignment.centerRight,
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: const Icon(Icons.delete, color: Colors.white),
                // ),
                //
                // // Action selon la direction
                // onDismissed: (direction) {
                //   if (direction == DismissDirection.startToEnd) {
                //     // Archive
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('$item archivé')),
                //     );
                //   } else if (direction == DismissDirection.endToStart) {
                //     // Supprime
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('$item supprimé')),
                //     );
                //   }
                // },
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
            )
          : _isLoading
          ? noContent
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
