
import 'package:flutter/material.dart';

import '../data/meal.data.dart';
import '../models/filter_option.model.dart';
import '../models/meal.model.dart';
import '../widgets/main_drawer.dart';
import 'category.screen.dart';
import 'filters.screen.dart';
import 'meal.screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<FilterOption, bool> _selectedFilters = kInitialFilters;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showMessage('Le plat a été retiré des favoris.');
      } else {
        _favoriteMeals.add(meal);
        _showMessage('Le plat a été ajouté aux favoris.');
      }
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop(); // ferme le drawer
    if (identifier == 'filters') {
      await Navigator.of(
            context,
          )
          .push<Map<FilterOption, bool>>(
            MaterialPageRoute(builder: (ctx) =>   FiltersScreen(filterOptions: _selectedFilters)),
          )
          .then((result) => setState(() => _selectedFilters = result ?? kInitialFilters));
    } else if (identifier == 'meals') {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final available = mealsData.where((meal) {
      return _selectedFilters[FilterOption.glutenFree]! && !meal.isGlutenFree ||
              _selectedFilters[FilterOption.lactoseFree]! && !meal.isLactoseFree ||
              _selectedFilters[FilterOption.vegetarian]! && !meal.isVegetarian ||
              _selectedFilters[FilterOption.vegan]! && !meal.isVegan
          ? false
          : true;
    }).toList();
    Widget activePage = CategoryScreen(onToggleFavorite: _toggleFavorite, availableMeals: available);
    String activePageTitle = 'Catégories';
    if (_selectedPageIndex == 1) {
      activePage = MealScreen(meals: _favoriteMeals, onToggleFavorite: _toggleFavorite);
      activePageTitle = 'Mes Favoris';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
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
