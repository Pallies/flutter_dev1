import 'package:first_app/_training_part/part5/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//  Provider pour des listes qui sont immuables
final mealsProvider = Provider((ref) => dummyMeals);
