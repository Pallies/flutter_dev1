import 'package:flutter/material.dart';

import '../models/meal.model.dart';
import '../widgets/meal_item.widget.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, this.title, required this.meals,required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, i) => MealItem(meal: meals[i],onToggleFavorite:onToggleFavorite),
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
