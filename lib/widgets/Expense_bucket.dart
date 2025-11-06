import 'package:first_app/models/expense.dart';
import '../models/enum/category.enum.dart';


class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    // double sum = 0;
    // for (final expense in expenses) {
    //   sum += expense.amount;
    // }
    // return sum;
    return expenses.map((expense)=>expense.amount).fold(0.0, (previousValue, element) => previousValue + element);
  }
}
