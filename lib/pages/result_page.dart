import 'package:sa_lr1_app/pages/tree_view_page.dart';
import 'package:sa_lr1_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(
      {super.key,
      this.adjacencyMatrix,
      this.newAdjacencyMatrix,
      this.renames,
      this.incidenceMatrix});

  final List<List<int>>? adjacencyMatrix;
  final List<List<int>>? newAdjacencyMatrix;
  final List<int>? renames;
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
                    builder: (context) => TreeViewPage(
                        adjacencyMatrix: widget.adjacencyMatrix,
                        renames: widget.renames),
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
            Center(child: const Text('Старая матрица смежности')),
            DataTable(
              columns: _a_buildColumns(),
              rows: _a_buildRows(),
              columnSpacing: 0.0,
            ),
            Center(child: const Text('Новая матрица смежности')),
            DataTable(
              columns: _na_buildColumns(),
              rows: _na_buildRows(),
              columnSpacing: 0.0,
            ),
            DataTable(
              columns: _oi_buildColumns(),
              rows: _oi_buildRows(),
              columnSpacing: 0.0,
            ),
            DataTable(
              columns: _ni_buildColumns(),
              rows: _ni_buildRows(),
              columnSpacing: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  // Создание столбцов таблицы
  List<DataColumn> _oi_buildColumns() {
    List<DataColumn> columns = [];
    columns.add(const DataColumn(label: Text(' ')));
    columns.add(const DataColumn(label: Text('Старые правые инциденции')));
    return columns;
  }

  List<DataColumn> _ni_buildColumns() {
    List<DataColumn> columns = [];
    columns.add(const DataColumn(label: Text(' ')));
    columns.add(const DataColumn(label: Text('Новые правые инциденции')));
    return columns;
  }

  // Создание строк таблицы
  List<DataRow> _ni_buildRows() {
    return widget.incidenceMatrix!.asMap().entries.map((entry) {
      int rowIndex = entry.key;
      List<int> rowData = entry.value;
      return DataRow(
        cells: _ni_buildCellsForRow(rowIndex, rowData),
      );
    }).toList();
  }

  // Создание ячеек для строки таблицы
  List<DataCell> _ni_buildCellsForRow(int rowIndex, List<int> rowData) {
    List<DataCell> cells = [];

    cells.add(DataCell(
        Text('${rowIndex + 1}'))); // Добавляем цифровую метку слева от строки

    String text = '';

    for (int i = 0; i < widget.newAdjacencyMatrix!.length; i++) {
      if (widget.newAdjacencyMatrix![rowIndex][i] == 1) {
        text += (i + 1).toString() + '    ';
      }
    }

    cells.add(DataCell(Text(text)));

    return cells;
  }

  // Создание строк таблицы
  List<DataRow> _oi_buildRows() {
    return widget.incidenceMatrix!.asMap().entries.map((entry) {
      int rowIndex = entry.key;
      List<int> rowData = entry.value;
      return DataRow(
        cells: _oi_buildCellsForRow(rowIndex, rowData),
      );
    }).toList();
  }

  // Создание ячеек для строки таблицы
  List<DataCell> _oi_buildCellsForRow(int rowIndex, List<int> rowData) {
    List<DataCell> cells = [];

    cells.add(DataCell(
        Text('${rowIndex + 1}'))); // Добавляем цифровую метку слева от строки

    String text = '';

    for (int i = 0; i < widget.adjacencyMatrix!.length; i++) {
      if (widget.adjacencyMatrix![rowIndex][i] == 1) {
        text += (i + 1).toString() + '    ';
      }
    }

    cells.add(DataCell(Text(text)));

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

  // Создание столбцов таблицы
  List<DataColumn> _na_buildColumns() {
    List<DataColumn> columns = [];
    columns.add(const DataColumn(label: Text(' ')));
    for (int i = 0; i < widget.newAdjacencyMatrix!.first.length; i++) {
      columns.add(DataColumn(label: Text((i + 1).toString())));
    }
    return columns;
  }

  // Создание строк таблицы
  List<DataRow> _na_buildRows() {
    return widget.newAdjacencyMatrix!.asMap().entries.map((entry) {
      int rowIndex = entry.key;
      List<int> rowData = entry.value;
      return DataRow(
        cells: _na_buildCellsForRow(rowIndex, rowData),
      );
    }).toList();
  }

  // Создание ячеек для строки таблицы
  List<DataCell> _na_buildCellsForRow(int rowIndex, List<int> rowData) {
    List<DataCell> cells = [];
    cells.add(DataCell(
        Text('${rowIndex + 1}'))); // Добавляем цифровую метку слева от строки
    for (int cellData in rowData) {
      cells.add(DataCell(Text('$cellData')));
    }
    return cells;
  }
}
