import 'package:first_app/data/meal.data.dart';
import 'package:first_app/screens/category.screen.dart';
import 'package:first_app/screens/meal.screen.dart';
import 'package:flutter/material.dart';

import '../models/meal.model.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        mealsData.remove(meal);
      } else {
        mealsData.add(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen();
    String activePageTitle = 'Catégories';
    if (_selectedPageIndex == 1) {
      activePage = MealScreen(meals: _favoriteMeals);
      activePageTitle = 'Mes Favoris';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoris',
          ),
        ],
      ),
    );
  }
}
