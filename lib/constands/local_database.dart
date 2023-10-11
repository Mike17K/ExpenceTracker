const dbName = 'expences_database.db';

const categoryTable = 'category';
const categoryId = 'id';
const categoryName = 'name';

const createCategoryTableQuery = '''
CREATE TABLE $categoryTable (
  $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
  $categoryName TEXT
)
''';

const expenseTable = 'expense';
const expenseId = 'id';
const expenseCategoryId = 'categoryId';
const expenseAmount = 'amount';
const expenseDate = 'date';
const expenseDescription = 'description';

const createExpenseTableQuery = '''
CREATE TABLE $expenseTable (
  $expenseId INTEGER PRIMARY KEY AUTOINCREMENT,
  $expenseCategoryId INTEGER,
  $expenseAmount REAL,
  $expenseDate TEXT,
  $expenseDescription TEXT,
  FOREIGN KEY ($expenseCategoryId) REFERENCES $categoryTable($categoryId)
)
''';
