import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'enum/category.enum.dart';

const uuid = Uuid();
final DateFormat formatter = DateFormat('dd/MM/yyyy');
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formatDate => formatter.format(date);

  IconData get icon => switch (category) {
    Category.food => Icons.fastfood,
    Category.leisure => Icons.movie,
    Category.travel => Icons.flight_takeoff,
    Category.work => Icons.work,
  };
}
