import 'package:flutter/material.dart';


import '../models/data/expenses-list.dart';
import '../models/expense.dart';
import 'chart/chart.dart';
import 'expenses_list/expense_crud.dart';
import 'expenses_list/expense_factory.dart';
import 'expenses_list/expense_list.dart';

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
      useSafeArea: true,// /!\ utilisation de l'espace sécurisé pour les composants
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>
          ExpenseFactory(onAddExpense: (expense) => _expenseCrud.addExpense(setState, expense)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      body: width < 600
          ? Column(
              children: [
                Expanded(
                  child: Chart(expenses: _expenses),
                ),
                Expanded(
                  child: _expenses.isEmpty
                      ? Center(child: Text('Nothing List'))
                      : ExpenseList(
                          expenses: _expenses,
                          onRemoveExpense: (expense) =>
                              _expenseCrud.removeExpense(setState, expense),
                        ),
                ),
              ],
            )
          : SizedBox(height:double.infinity,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Chart(expenses: _expenses),
                  ),
                ),
                Expanded(
                  child: _expenses.isEmpty
                      ? Center(child: Text('Nothing List'))
                      : ExpenseList(
                          expenses: _expenses,
                          onRemoveExpense: (expense) =>
                              _expenseCrud.removeExpense(setState, expense),
                        ),
                ),
              ],
            ),),
    );
  }
}
