import 'package:first_app/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//  Provider pour des listes qui sont immuables
final mealsProvider = Provider((ref) => dummyMeals);
