import 'package:first_app/_training_part/part7/data/categories.dart';
import 'package:first_app/_training_part/part7/models/grocery_item.model.dart';
import 'package:first_app/_training_part/part7/models/category.model.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
