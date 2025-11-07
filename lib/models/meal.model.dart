import 'package:first_app/extentions/string.extention.dart';


enum Complexity {
  simple('simple'),
  challenging('difficile'),
  hard('extrême');

  final String label;

  const Complexity(this.label);

  get text {
    return label.toCapitalize();
  }
}

enum Affordability {
  affordable('abordable'),
  pricey('cher'),
  luxurious('luxueux');

  final String label;

  const Affordability(this.label);

  get text {
    return label.toCapitalize();
  }
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  bool containsCategories(String category) {
    return categories.contains(category);
  }
}
