import 'package:flutter/material.dart';
      import 'package:flutter_riverpod/flutter_riverpod.dart';

      import '../data/dummy_data.dart';
      import '../models/category.dart';
      import '../providers/filters.provider.dart';
      import '../widgets/category_grid_item.dart';
      import 'meals.dart';

      class CategoriesScreen extends ConsumerWidget {
        const CategoriesScreen({super.key});

        void _selectCategory(BuildContext context, Category category, WidgetRef ref) {
          final filteredMeals = ref
              .watch(filteredMealsProvider)
              .where((meal) => meal.categories.contains(category.id))
              .toList();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
              ),
            ),
          );
        }

        @override
        Widget build(BuildContext context, WidgetRef ref) {
          return GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: availableCategories.length,
            itemBuilder: (_, index) {
              final category = availableCategories[index];
              return CategoryGridItem(
                category: category,
                onSelectCategory: () => _selectCategory(context, category, ref),
              );
            },
          );
        }
      }
