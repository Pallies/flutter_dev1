import 'package:flutter/material.dart';

import '../models/meal.model.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    var index=1;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.star), //Icon(Icons.star_border),
          ),
        ],
      ),
      body: ListView(
        children:    [
            Image.network(
              meal.imageUrl,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingrédients:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            ...meal.ingredients.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75, vertical:2),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              'Etapes:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            ...meal.steps.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                child: Text(
                  '${index++} - $item',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],

      ),
    );
  }
}
