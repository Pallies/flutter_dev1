import 'package:first_app/_training_part/part5/providers/meal.provider.dart';
import 'package:first_app/_training_part/part5/screens/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/meal.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  bool get(Filter filter) {
    return state[filter]!;
  }
}

final filterMealsProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

Provider<bool> filterProvider(Filter filter) =>
    Provider<bool>((ref) => ref.watch(filterMealsProvider)[filter]!);

final filterGlutenProvider = filterProvider(Filter.glutenFree);
final filterLactoseProvider = filterProvider(Filter.lactoseFree);
final filterVegetarianProvider = filterProvider(Filter.vegetarian);
final filterVeganProvider = filterProvider(Filter.vegan);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  return meals.where((meal) {
    return (ref.watch(filterGlutenProvider) && !meal.isGlutenFree) ||
            (ref.watch(filterLactoseProvider) && !meal.isLactoseFree) ||
            (ref.watch(filterVegetarianProvider) && !meal.isVegetarian) ||
            (ref.watch(filterVeganProvider) && !meal.isVegan)
        ? false
        : true;
  }).toList();
});
