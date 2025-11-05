import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.item, {super.key});

  final Expense item;

  String convertToDate(DateTime date) {
    return '${date.day}\/${date.month}\/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Text(item.title),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${item.amount.toStringAsFixed(2)} €'),
                const Spacer(),
                Row(
                  children: [
                    Icon(item.icon, size: 16),
                    const SizedBox(width: 5),
                    Text(item.formatDate),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
