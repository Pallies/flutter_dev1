import 'package:first_app/models/category.model.dart';
import 'package:first_app/widgets/category_item.widget.dart';
import 'package:flutter/material.dart';

import '../data/category.data.dart';
import '../data/meal.data.dart';
import 'meal.screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _mealScreenRouter(BuildContext context,Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: mealsData.where((meal) => meal.containsCategories(category.id)).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Screen'),
      ),
      // body: GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder), liste dynamique avec for in ... ou list
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...categoriesData.map(
            (item) => CategoryItem(category: item, categoryEvent: ()=>_mealScreenRouter(context,item)),
          ),
          // for (final Category item in categoriesData) CategoryItem(category: item, handleCategoryTap: ()=>_selectCategory(context,item)),
        ],
      ),
    );
  }
}
