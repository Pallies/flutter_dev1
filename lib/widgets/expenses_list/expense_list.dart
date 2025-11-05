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
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            vertical: Theme.of(context).cardTheme.margin!.vertical / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Delete', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
              SizedBox(width: 8),
              Icon(Icons.delete, color: Colors.white),
            ],
          ),
        ),
        child: ExpenseItem(expenses[i]),
      ),
      itemCount: expenses.length,
    );
  }
}
