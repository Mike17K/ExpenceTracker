import 'package:expenses_tracker/constands/local_database.dart';

class Expense {
  final String id;
  final String categoryId;
  final double amount;
  final DateTime date;
  final String description;

  Expense({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
  });

  Expense.fromMap(Map<String, dynamic> map)
      : id = map[expenseId],
        categoryId = map[expenseCategoryId],
        amount = map[expenseAmount],
        date = map[expenseDate],
        description = map[expenseDescription];
}
