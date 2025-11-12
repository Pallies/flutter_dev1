import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:first_app/_training_part/part6/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
