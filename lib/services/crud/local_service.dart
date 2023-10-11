import 'package:expenses_tracker/constands/local_database.dart';
import 'package:expenses_tracker/models/Category.dart';
import 'package:expenses_tracker/models/Expense.dart';
import 'package:path/path.dart' show join;

import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, MissingPlatformDirectoryException;
import 'package:expenses_tracker/services/crud/crud_exceptions.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  Database? _db;
  bool isDbOpen = false;

  static final LocalDatabaseService _shared =
      LocalDatabaseService._sharedInstance();
  LocalDatabaseService._sharedInstance();
  factory LocalDatabaseService() => _shared;

  Future<void> clearDatabase() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.delete(categoryTable);
    await db.delete(expenseTable);
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenedException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      // create category table
      await db.execute(createCategoryTableQuery);

      // create expences table
      await db.execute(createExpenseTableQuery);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }

  Future<void> _ensureDbIsOpen() async {
    if (isDbOpen) return;
    try {
      await open();
      isDbOpen = true;
    } on DatabaseAlreadyOpenedException {
      // empty
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  // Specific to category table
  Future<List<Category>?> getAllCategories() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final result = await db.query(categoryTable);
    if (result.isEmpty) {
      return null;
    } else {
      return result.map((e) => Category.fromMap(e)).toList();
    }
  }

  Future<Category?> getCategoryByName(String name) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final result = await db
        .query(categoryTable, where: '$categoryName = ?', whereArgs: [name]);
    if (result.isEmpty) {
      return null;
    } else {
      return Category.fromMap(result.first);
    }
  }

  Future<int> insertCategoryByName(String name) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // make sure that the category name is unique
    final existingCategory = await getCategoryByName(name);
    if (existingCategory != null) {
      throw CategoryAlreadyExistsException();
    }
    final values = <String, dynamic>{categoryName: name};
    return await db.insert(categoryTable, values);
  }

  Future<int> deleteCategoryByName(String name) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    return await db
        .delete(categoryTable, where: '$categoryName = ?', whereArgs: [name]);
  }

  Future<int> updateCategoryName(String oldName, String newName) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final values = <String, dynamic>{categoryName: newName};
    return await db.update(categoryTable, values,
        where: '$categoryName = ?', whereArgs: [oldName]);
  }

  // Specific to expense table
  Future<List<Expense>?> getAllExpenses() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final result = await db.query(expenseTable);
    if (result.isEmpty) {
      return null;
    } else {
      return result.map((e) => Expense.fromMap(e)).toList();
    }
  }

  Future<void> insertExpense(Expense expense) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final values = <String, dynamic>{
      expenseCategoryId: expense.categoryId,
      expenseAmount: expense.amount,
      expenseDate: expense.date.toIso8601String(),
      expenseDescription: expense.description,
    };
    await db.insert(expenseTable, values);
  }

  Future<List<Expense>?> getExpensesByCategoryId(int categoryId) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final result = await db.query(expenseTable,
        where: '$expenseCategoryId = ?', whereArgs: [categoryId]);
    if (result.isEmpty) {
      return null;
    } else {
      return result.map((e) => Expense.fromMap(e)).toList();
    }
  }
}
