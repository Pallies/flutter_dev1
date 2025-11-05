import 'package:first_app/models/expense.dart';
import 'package:flutter/material.dart';

import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) => Dismissible(
        key: ValueKey(expenses[i]),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            onRemoveExpense(expenses[i]);
          }
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ExpenseItem(expenses[i]),
      ),
      itemCount: expenses.length,
    );
  }
}
