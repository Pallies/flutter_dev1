import 'package:first_app/widgets/expenses_list/expense_crud.dart';
import 'package:first_app/widgets/expenses_list/expense_list.dart';
import 'package:first_app/models/data/expenses-list.dart';
import 'package:first_app/widgets/expenses_list/expense_factory.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = expensesList;
  late final ExpenseCrud _expenseCrud;

  @override
  initState() {
    super.initState();
    _expenseCrud = ExpenseCrud(context: context);
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>
          ExpenseFactory(onAddExpense: (expense) => _expenseCrud.addExpense(setState, expense)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Expenses Tracker',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('List of Expenses'),
          Expanded(
            child: _expenses.isEmpty
                ? Center(child: Text('Nothing List'))
                : ExpenseList(
                    expenses: _expenses,
                    onRemoveExpense: (expense) => _expenseCrud.removeExpense(setState, expense),
                  ),
          ),
        ],
      ),
    );
  }
}
