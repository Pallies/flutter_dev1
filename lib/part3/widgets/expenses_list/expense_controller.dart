import 'package:flutter/material.dart';

import '../../models/enum/category.enum.dart';
import '../../models/expense.dart';

class ExpenseController {
  ExpenseController();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? date;
  Category category = Category.leisure;

  get title {
    return _titleController;
  }

  get amount {
    return _amountController;
  }

  bool isValid() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0;
    final dateIsValid = date != null;

    return enteredTitle.isNotEmpty && amountIsValid && dateIsValid;
  }
  Expense expenseValues() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.parse(_amountController.text);

    return Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: date!,
      category: category,
    );
  }
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
  }
}
