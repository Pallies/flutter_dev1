import 'package:first_app/_training_part/part8/data/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:first_app/_training_part/part8/models/category.model.dart';
import 'package:first_app/_training_part/part8/models/grocery_item.model.dart';

class GloceryForms {
  final String name;

  final int quantity;

  final Category category;

  GloceryForms({this.name = "", this.quantity = 1, required this.category});

  GloceryForms onChanges({String? name, int? quantity, Category? category}) {
    return GloceryForms(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
    );
  }
}

class GroceryFormNotifier extends StateNotifier<GloceryForms> {
  GroceryFormNotifier() : super(GloceryForms(category: categories[Categories.vegetables]!));

  get formState => state;

  get formGroceryItem {
    var tmp = GroceryItem(
      id: DateTime.now().toString(),
      name: state.name,
      quantity: state.quantity,
      category: state.category,
    );
    clear();
    return tmp;
  }

  void updateName(String name) {
    state = state.onChanges(name: name);
  }

  get name => state.name;

  get quantity => state.quantity;

  get category => state.category;

  void updateQuantity(int quantity) {
    state = state.onChanges(quantity: quantity);
  }

  void updateCategory(Category category) {
    state = state.onChanges(category: category);
  }

  bool isValid() {
    return state.name.isNotEmpty && state.quantity > 0;
  }

  void clear() {
    state = GloceryForms(name: '', quantity: 1, category: categories[Categories.vegetables]!);
    print(
      'Item: ${state.name}, Qty: ${state.quantity}, Cat: ${state.category.title}',
    );
  }
}

final groceryFormProvider = StateNotifierProvider<GroceryFormNotifier, GloceryForms>(
  (ref) => GroceryFormNotifier(),
);
final nameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();

  // écoute les changements utilisateur
  controller.addListener(() {
    ref.read(groceryFormProvider.notifier).updateName(controller.text);
  });

  // écoute les changements du provider et met à jour le texte
  ref.listen<GloceryForms>(groceryFormProvider, (previous, next) {
    if (controller.text != next.name) {
      controller.text = next.name;
    }
  });

  return controller;
});

final quantityControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();

  // écoute les changements utilisateur
  controller.addListener(() {
    final value = int.tryParse(controller.text) ?? 1;
    ref.read(groceryFormProvider.notifier).updateQuantity(value);
  });

  // écoute les changements du provider et met à jour le texte
  ref.listen<GloceryForms>(groceryFormProvider, (previous, next) {
    if (controller.text != next.quantity.toString()) {
      controller.text = next.quantity.toString();
    }
  });

  return controller;
});
