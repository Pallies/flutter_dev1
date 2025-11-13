import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/categories.dart';
import '../models/category.model.dart';

final categoriesProvider = Provider<Map<Categories,Category>>((ref) {
  return categories;
});
