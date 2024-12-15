class SqlQueries {
  SqlQueries._();

  ///=============================[queries]====================================
  static const String expensesTable = "expensesTable";
  static const String categoriesTable = "categoryTable";

  ///==========>> CREATE EXPENSES TABLE <<================
  static String get createExpensesTable {
    return '''
    CREATE TABLE $expensesTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expenseName TEXT,
    expenseValue REAL,
    expenseDate TEXT,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES $categoriesTable (id)
    )
    ''';
  }

  static String get createCategoriesTable {
    return '''
    CREATE TABLE $categoriesTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    eName TEXT
    )
    ''';
  }

  ///===========================================[select_query_for_filtering]
}
