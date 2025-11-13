import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:first_app/_training_part/part8/data/categories.dart';
import 'package:first_app/_training_part/part8/models/category.model.dart';

final categoriesProvider = Provider<Map<Categories,Category>>((ref) {
  return categories;
});
