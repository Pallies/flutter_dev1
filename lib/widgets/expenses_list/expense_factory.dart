
import 'package:first_app/models/enum/category.enum.dart';
import 'package:first_app/widgets/expenses_list/expense_controller.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseFactory extends StatefulWidget {
  const ExpenseFactory({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ExpenseFactory> createState() {
    return _ExpenseFactoryState();
  }
}

class _ExpenseFactoryState extends State<ExpenseFactory> {
  final _expenseController = ExpenseController();

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    setState(() {
      _expenseController.date = date;
    });
  }

  void _submitExpense() {
    if (!_expenseController.isValid()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please make sure all fields are filled correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      Navigator.pop(context);
      widget.onAddExpense(_expenseController.expenseValues());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB( 16,   50,16,16),
        child: Column(
          children: [
            TextField(
              controller: _expenseController.title,
              maxLength: 50,
              decoration: InputDecoration(labelText: 'Title'),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expenseController.amount,
                    keyboardType: TextInputType.number,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      suffix: Text('€'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _showDatePicker,
                        child: Text(_expenseController.date != null
                            ? formatter.format(_expenseController.date!)
                            : 'No Date Selected'),
                      ),
                      IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                  value: _expenseController.category,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _expenseController.category = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitExpense,
                  child: Text(
                    'Save Expand',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _expenseController.dispose();
    super.dispose();
  }
}
