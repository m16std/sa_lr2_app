import 'package:sa_lr1_app/pages/tree_view_page.dart';
import 'package:sa_lr1_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, this.adjacencyMatrix, this.incidenceMatrix});

  final List<List<int>>? adjacencyMatrix;
  final List<List<int>>? incidenceMatrix;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: Center(child: const Text('Полученные матрицы')),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TreeViewPage(adjacencyMatrix: widget.adjacencyMatrix),
                  ),
                );
              },
              child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 37,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.arrow_forward_ios)),
            ),
          ]),
      body: Container(
        //width: widget.adjacencyMatrix!.length * 55,
        height: 1000,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(child: const Text('Матрица смежности')),
            DataTable(
              columns: _a_buildColumns(),
              rows: _a_buildRows(),
              columnSpacing: 0.0,
            ),
            Center(child: const Text('Матрица инцидентности')),
            DataTable(
              columns: _i_buildColumns(),
              rows: _i_buildRows(),
              columnSpacing: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  // Создание столбцов таблицы
  List<DataColumn> _i_buildColumns() {
    List<DataColumn> columns = [];
    columns.add(const DataColumn(label: Text(' ')));
    for (int i = 0; i < widget.incidenceMatrix!.first.length; i++) {
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
  List<DataRow> _i_buildRows() {
    return widget.incidenceMatrix!.asMap().entries.map((entry) {
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
  List<DataColumn> _a_buildColumns() {
    List<DataColumn> columns = [];
    columns.add(const DataColumn(label: Text(' ')));
    for (int i = 0; i < widget.adjacencyMatrix!.first.length; i++) {
      columns.add(DataColumn(label: Text((i + 1).toString())));
    }
    return columns;
  }

  // Создание строк таблицы
  List<DataRow> _a_buildRows() {
    return widget.adjacencyMatrix!.asMap().entries.map((entry) {
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
}
