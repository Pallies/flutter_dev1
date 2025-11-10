import 'package:first_app/data/meal.data.dart';
import 'package:flutter/material.dart';

import '../models/meal.model.dart';
import '../widgets/meal_item.widget.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: mealsData.length,
      itemBuilder: (ctx, i) => MealItem(meal: mealsData[i]),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Text(
          'Aucun plat trouvé dans cette catégorie !',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
