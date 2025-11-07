
import 'package:flutter/material.dart';

import '../../models/enum/category.enum.dart';
import '../../models/expense.dart';
import 'expense_controller.dart';

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
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, contraints) {
        final width = contraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expenseController.title,
                            maxLength: 50,
                            decoration: InputDecoration(labelText: 'Title'),
                          ),
                        ),
                        const SizedBox(width: 24),
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
                      ],
                    )
                  else
                    TextField(
                      controller: _expenseController.title,
                      maxLength: 50,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: _showDatePicker,
                                child: Text(
                                  _expenseController.date != null
                                      ? formatter.format(_expenseController.date!)
                                      : 'No Date Selected',
                                ),
                              ),
                              IconButton(
                                onPressed: _showDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
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
                                child: Text(
                                  _expenseController.date != null
                                      ? formatter.format(_expenseController.date!)
                                      : 'No Date Selected',
                                ),
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
                  if (width >= 600)
                    Row(
                      children: [
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
                    )
                  else
                    Row(
                      children: [
                        if (width < 600)
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
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _expenseController.dispose();
    super.dispose();
  }
}
