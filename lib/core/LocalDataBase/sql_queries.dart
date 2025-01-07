class SqlQueries {
  SqlQueries._();

  ///=============================[queries]====================================
  static const String expensesTable = "expensesTable";
  static const String categoriesTable = "categoryTable";
  static const String incomeTable = "incomeTable";

  ///==========>> CREATE EXPENSES TABLE <<================
  static String get createExpensesTable {
    return '''
    CREATE TABLE $expensesTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expenseName TEXT,
    expenseValue REAL,
    expenseDate TEXT,
    categoryID INTEGER,
    categoryName TEXT,
    categoryEname TEXT,
    FOREIGN KEY (categoryName) REFERENCES $categoriesTable (name),
    FOREIGN KEY (categoryEname) REFERENCES $categoriesTable (eName),
    FOREIGN KEY (categoryID) REFERENCES $categoriesTable (id)
    )
    ''';
  }

  static String get createIncomeTable {
    return '''
    CREATE TABLE $incomeTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    incomeName TEXT,
    incomeValue REAL,
    incomeDate TEXT
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
