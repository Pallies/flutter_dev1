import '../enum/category.enum.dart';
import '../expense.dart';

final expensesList = [
  Expense(
    title: 'Flutter Course',
    amount: 19.99,
    date: DateTime.now(),
    category: Category.work,
  ),
  Expense(
    title: 'Cinema',
    amount: 15.00,
    date: DateTime.now(),
    category: Category.leisure,
  ),
  Expense(
    title: 'Pizza',
    amount: 8.99,
    date: DateTime.now(),
    category: Category.food,
  ),
  Expense(
    title: 'New Shoes',
    amount: 69.99,
    date: DateTime.now(),
    category: Category.travel,
  ),
];
