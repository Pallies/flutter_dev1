import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]);

  void toggleFavorite(Meal meal, context) {
    var message = '';
    ScaffoldMessenger.of(context).clearSnackBars();
    if (isFavorite(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      message = 'Meal is no longer a favorite.';
    } else {
      state = [...state, meal];
      message = 'Marked as a favorite!';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }

  void _showInfoMessage(String message) {}
}

// StateNotifierProvider pour gérer les listes dynamiques et dont les données peuvent changer
final favoritesMealsProvider = StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
  (ref) => FavoritesMealNotifier(),
);
final isMealFavoriteProvider = Provider.family<bool, Meal>(
  (ref, meal) {
    final favoriteMeals = ref.watch(favoritesMealsProvider);
    return favoriteMeals.contains(meal);
  },
);
