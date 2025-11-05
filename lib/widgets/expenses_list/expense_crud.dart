import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/data/expenses-list.dart';
import '../../models/expense.dart';

class ExpenseCrud {
  ExpenseCrud({required this.context});

  final BuildContext context;

  final List<Expense> _expenses = expensesList;

  void removeExpense(void Function(VoidCallback fn) state, Expense expense) {
    var index = _expenses.indexOf(expense);
    state(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} deleted.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'RollBack',
          onPressed: () {
            state(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void addExpense(void Function(VoidCallback fn) state, Expense expense) {
    state(() {
      _expenses.add(expense);
    });
  }
}
