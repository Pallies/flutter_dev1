import 'package:first_app/_training_part/part7/data/dummy_items.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/grocery_item.model.dart';

class GroceryNotifier extends StateNotifier<List<GroceryItem>>{
  GroceryNotifier(): super(groceryItems);

  void addItem(item){
    state = [...state, item];
  }
  void removeItem(itemId){
    state = state.where((item) => item.id != itemId).toList();
  }
}

final groceryNotifier = StateNotifierProvider<GroceryNotifier,List<GroceryItem>>((ref)=> GroceryNotifier());
