import 'package:flutter/material.dart';

// Создание столбцов таблицы
List<DataColumn> _i_buildColumns(List<List<int>> incidenceMatrix) {
  List<DataColumn> columns = [];
  columns.add(const DataColumn(label: Text(' ')));
  for (int i = 0; i < incidenceMatrix.first.length; i++) {
    columns.add(DataColumn(label: Text(_i_getColumnLabel(i))));
  }
  return columns;
}

// Получение метки для столбца на основе его индекса (a, b, c, ...)
String _i_getColumnLabel(int index) {
  // В ASCII таблице символ 'a' имеет код 97, 'b' - 98 и т.д.
  return String.fromCharCode(97 + index);
}

// Создание строк таблицы
List<DataRow> _i_buildRows(List<List<int>> incidenceMatrix) {
  return incidenceMatrix.asMap().entries.map((entry) {
    int rowIndex = entry.key;
    List<int> rowData = entry.value;
    return DataRow(
      cells: _i_buildCellsForRow(rowIndex, rowData),
    );
  }).toList();
}

// Создание ячеек для строки таблицы
List<DataCell> _i_buildCellsForRow(int rowIndex, List<int> rowData) {
  List<DataCell> cells = [];
  cells.add(DataCell(
      Text('${rowIndex + 1}'))); // Добавляем цифровую метку слева от строки
  for (int cellData in rowData) {
    cells.add(DataCell(Text('$cellData')));
  }
  return cells;
}

// Создание столбцов таблицы
List<DataColumn> _a_buildColumns(List<List<int>> adjacencyMatrix) {
  List<DataColumn> columns = [];
  columns.add(const DataColumn(label: Text(' ')));
  for (int i = 0; i < adjacencyMatrix.first.length; i++) {
    columns.add(DataColumn(label: Text(i.toString())));
  }
  return columns;
}

// Создание строк таблицы
List<DataRow> _a_buildRows(List<List<int>> adjacencyMatrix) {
  return adjacencyMatrix.asMap().entries.map((entry) {
    int rowIndex = entry.key;
    List<int> rowData = entry.value;
    return DataRow(
      cells: _a_buildCellsForRow(rowIndex, rowData),
    );
  }).toList();
}

// Создание ячеек для строки таблицы
List<DataCell> _a_buildCellsForRow(int rowIndex, List<int> rowData) {
  List<DataCell> cells = [];
  cells.add(DataCell(
      Text('${rowIndex + 1}'))); // Добавляем цифровую метку слева от строки
  for (int cellData in rowData) {
    cells.add(DataCell(Text('$cellData')));
  }
  return cells;
}
