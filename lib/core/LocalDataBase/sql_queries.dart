class SqlQueries {
  SqlQueries._();

  ///=============================[queries]====================================
  static const String expensesTable = "expensesTable";
  static const String categoriesTable = "categoryTable";
  static const String incomeTable = "incomeTable";
  static const String statisticsDetail = "statisticsDetail";

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

  ///===========================================[create_statistics_model]
  static String get createstatisticsDetailTable {
    ;
    return '''
    CREATE TABLE $statisticsDetail (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    label TEXT,
    value REAL DEFAULT 0.0,
    qty INTEGER DEFAULT 1,
    totalQty INTEGER DEFAULT 1,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES $statisticsDetail (id),
    totalValue REAL DEFAULT 0.0
    )
    ''';
  }
}
