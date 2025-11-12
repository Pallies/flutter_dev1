import 'package:flutter/material.dart';

import 'package:first_app/_training_part/part6/data/dummy_data.dart';
import 'package:first_app/_training_part/part6/models/meal.dart';
import 'package:first_app/_training_part/part6/widgets/category_grid_item.dart';
import 'package:first_app/_training_part/part6/screens/meals.dart';
import 'package:first_app/_training_part/part6/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// SingleTickerProviderStateMixin pour un seul et unique AnimationController
// TickerProviderStateMixin pour plusieurs AnimationController
class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      // lowerBound: 0, valeur par défaut
      // upperBound: 1, valeur par défaut
    );
    // lancer l'animation automatiquement au démarrage de l'écran
    //  autre repeat(), reverse(), etc.
    _animationController.forward();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        ),
      ),
      //  tous les élément dans le child ne seront pas rebuild à chaque frame de l'animation
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
