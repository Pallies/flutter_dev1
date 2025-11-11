
import 'package:flutter/material.dart';
import 'package:first_app/_training_part/part4/models/category.model.dart';
import 'package:first_app/_training_part/part4/widgets/category_item.widget.dart';
import '../data/category.data.dart';
import '../data/meal.data.dart';
import '../models/meal.model.dart';
import 'meal.screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;

  void _mealScreenRouter(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: mealsData.where((meal) => meal.containsCategories(category.id)).toList(),
            onToggleFavorite:onToggleFavorite
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder), liste dynamique avec for in ... ou list
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...categoriesData.map(
          (item) =>
              CategoryItem(category: item, categoryEvent: () => _mealScreenRouter(context, item)),
        ),
        // for (final Category item in categoriesData) CategoryItem(category: item, handleCategoryTap: ()=>_selectCategory(context,item)),
      ],
    );
  }
}
