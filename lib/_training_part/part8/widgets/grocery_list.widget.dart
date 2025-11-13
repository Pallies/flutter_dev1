import 'package:first_app/_training_part/part8/providers/grocery.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../part7/widgets/new_grocery_item.widget.dart';
import '../models/grocery_item.model.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  late final List<GroceryItem> groceryItems = ref.read(groceryNotifier);

  void navigationToNewGroceryItem() async {
    var groceryItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (context) => const NewGroceryItem()));
    ref.read(groceryNotifier.notifier).addItem(groceryItem);
  }

  @override
  Widget build(BuildContext context) {
    Widget _noContent = Center(
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
    final List<GroceryItem> groceries = ref.watch(groceryNotifier);
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
      body: groceries.isNotEmpty
          ? ListView.builder(
              itemCount: groceries.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(groceries[index].id),
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
                  ref.read(groceryNotifier.notifier).removeItem(groceries[index].id);
                },
                child: ListTile(
                  title: Text(groceries[index].name),
                  leading: Container(width: 24, height: 24, color: groceries[index].category.color),
                  trailing: Text(groceries[index].quantity.toString()),
                ),
              ),
            )
          : _noContent,
    );
  }
}
