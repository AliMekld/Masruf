class SqlQueries {
  SqlQueries._();

  ///=============================[queries]====================================

  ///==========>> CREATE EXPENSES TABLE <<================
  static String createExpensesTable(String tableName) {
    return '''
    CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expenseName TEXT,
    expenseValue REAL,
    expenseDate TEXT,
    category TEXT
    )
    ''';
  }

  ///===========================================[select_query_for_filtering]
}
