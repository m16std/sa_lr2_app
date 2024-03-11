import 'package:flutter/cupertino.dart';
import 'package:sa_lr1_app/pages/result_page.dart';
import 'package:sa_lr1_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TablePage(),
    );
  }
}

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  int rowCount = 2;
  int columnCount = 2;
  List<List<int>> tableData = [[]];
  List<List<TextEditingController>> controllers = [[]];

  @override
  void initState() {
    super.initState();
    _initializeTable();
  }

  void _initializeTable() {
    tableData.clear();
    for (int i = 0; i < rowCount; i++) {
      List<int> row = List.filled(columnCount, 0);
      tableData.add(row);
    }
    _initializeControllers();
  }

  void _initializeControllers() {
    controllers.clear();
    for (int i = 0; i < rowCount; i++) {
      List<TextEditingController> rowControllers = [];
      for (int j = 0; j < columnCount; j++) {
        TextEditingController controller = TextEditingController();
        controller.text = '0';
        rowControllers.add(controller);
      }
      controllers.add(rowControllers);
    }
  }

  void _saveTableData() {
    List<List<int>> newData = [];
    for (int i = 0; i < rowCount; i++) {
      List<int> row = [];
      for (int j = 0; j < columnCount; j++) {
        int value = int.parse(controllers[i][j].text);
        row.add(value);
      }
      newData.add(row);
    }
    setState(() {
      tableData = newData;
    });
    _compute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Матрица инцидентности'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Вершин: '),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: rowCount,
                  onChanged: (value) {
                    setState(() {
                      rowCount = value!;
                      _initializeTable();
                    });
                  },
                  items: List.generate(15, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                ),
                SizedBox(width: 20),
                Text('Дуг: '),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: columnCount,
                  onChanged: (value) {
                    setState(() {
                      columnCount = value!;
                      _initializeTable();
                    });
                  },
                  items: List.generate(15, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DataTable(
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    columns: collumns(columnCount),
                    rows: List.generate(rowCount, (i) {
                      return DataRow(
                        cells: List.generate(columnCount, (j) {
                          return DataCell(
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 16) /
                                  columnCount,
                              child: Center(
                                child: TextField(
                                  controller: controllers[i][j],
                                  decoration: InputDecoration(
                                    //border: OutlineInputBorder(),
                                    hintText: 'Enter data (-1, 0, 1)',
                                  ),
                                  onChanged: (value) {
                                    if (value != '-' &&
                                        value != '0' &&
                                        value != '1' &&
                                        value != '-1') {
                                      controllers[i][j].text = '';
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTableData,
              child: Text('Перевести'),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> collumns(int count) {
    List<DataColumn> collumns_list = List.generate(
        count,
        (index) => DataColumn(
            label: Text('${String.fromCharCode(97 + index).toUpperCase()}')));
    return collumns_list;
  }

  List<DataCell> cells(int i, int count) {
    List<DataCell> cells_list = <DataCell>[DataCell(Text(' '))];

    for (int j = 0; j < count; j++) {
      cells_list.add(DataCell(
        SizedBox(
          width: (MediaQuery.of(context).size.width - 16) / columnCount,
          child: Center(
            child: TextField(
              controller: controllers[i][j],
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: 'Enter data (-1, 0, 1)',
              ),
              onChanged: (value) {
                if (value != '-' &&
                    value != '0' &&
                    value != '1' &&
                    value != '-1') {
                  controllers[i][j].text = '';
                }
              },
            ),
          ),
        ),
      ));
    }
    return cells_list;
  }

  List<int> stringToList(String input) {
    List<String> numbersAsString = input.split(' ');
    List<int> numbers = numbersAsString.map((str) => int.parse(str)).toList();
    return numbers;
  }

  List<List<int>> getIncidenceMatrix(List<List<int>> ListOfincidence) {
    int arc_count = 0;

    for (int j = 0; j < ListOfincidence.length; j++) {
      for (int i = 0; i < ListOfincidence[j].length; i++) {
        arc_count += 1;
      }
    }

    List<List<int>> IncidenceMatrix = List.generate(
        ListOfincidence.length, (_) => List<int>.filled(arc_count, 0));

    int arc_num = 0;

    for (int j = 0; j < ListOfincidence.length; j++) {
      for (int i = 0; i < ListOfincidence[j].length; i++) {
        if (ListOfincidence[j][i] < ListOfincidence.length) {
          IncidenceMatrix[ListOfincidence[j][i]][arc_num] = -1;
          IncidenceMatrix[j][arc_num] = 1;
          if (ListOfincidence[j][i] == j) {
            IncidenceMatrix[j][arc_num] = 2;
          }
          arc_num += 1;
        }
      }
    }
    return IncidenceMatrix;
  }

  List<List<int>> getAdjacencyMatrix(List<List<int>> ListOfincidence) {
    List<List<int>> AdjacencyMatrix = List.generate(ListOfincidence.length,
        (_) => List<int>.filled(ListOfincidence.length, 0));

    for (int j = 0; j < ListOfincidence.length; j++) {
      for (int i = 0; i < ListOfincidence[j].length; i++) {
        if (ListOfincidence[j][i] < ListOfincidence.length)
          AdjacencyMatrix[j][ListOfincidence[j][i]] = 1;
      }
    }

    return AdjacencyMatrix;
  }

  List<List<int>> swap(
      List<List<int>> matrix, List<int> position, int a, int b) {
    int n = matrix.length;
    int bufer;
    for (int i = 0; i < n; i++) {
      bufer = matrix[i][a];
      matrix[i][a] = matrix[i][b];
      matrix[i][b] = bufer;
    }
    for (int i = 0; i < n; i++) {
      bufer = matrix[a][i];
      matrix[a][i] = matrix[b][i];
      matrix[b][i] = bufer;
    }
    bufer = position[a];
    position[a] = position[b];
    position[b] = bufer;

    return matrix;
  }

  List<int> getRenames(List<List<int>> AdjacencyMatrix) {
    List<int> sums = List<int>.filled(AdjacencyMatrix.length, 0);
    List<int> renamed = [];
    List<int> last_renamed = [];
    List<int> rename = List<int>.filled(AdjacencyMatrix.length, 0);
    int n = AdjacencyMatrix.length;

    for (int j = 0; j < n; j++) {
      for (int i = 0; i < n; i++) {
        sums[j] += AdjacencyMatrix[i][j];
      }
    }

    print(sums);

    int k = 0;

    while (k < n) {
      int flag = -1;

      for (int j = 0; j < n; j++) {
        if (sums[j] == 0 && !renamed.contains(j)) {
          rename[k] = j;
          renamed.add(j);
          last_renamed.add(j);
          flag = 1;
          k += 1;
        }
      }

      if (flag == -1) {
        print('Невозможно выполнить');
        return rename;
      }

      for (int i = 0; i < last_renamed.length; i++) {
        for (int j = 0; j < n; j++) {
          sums[j] -= AdjacencyMatrix[last_renamed[i]][j];
        }
      }

      last_renamed = [];

      print(sums);
    }
    return rename;
  }

  List<List<int>> orderFunction(List<List<int>> AdjacencyMatrix) {
    List<int> sums = List<int>.filled(AdjacencyMatrix.length, 0);
    List<int> renamed = [];
    List<int> rename = getRenames(AdjacencyMatrix);
    int n = AdjacencyMatrix.length;

    List<int> position = [];
    for (int i = 0; i < n; i++) {
      position.add(i);
    }

    for (int i = 0; i < n; i++) {
      if (position[i] != rename[i]) {
        swap(AdjacencyMatrix, position, position.indexOf(rename[i]), i);
      }
    }

    return AdjacencyMatrix;
  }

  void _compute(BuildContext context) {
    try {
      List<List<int>> ListOfincidence = List.generate(rowCount, (_) => <int>[]);

      for (int j = 0; j < columnCount; j++) {
        for (int i = 0; i < rowCount; i++) {
          if (tableData[i][j] == 1) {
            for (int k = 0; k < rowCount; k++) {
              if (tableData[k][j] == -1) {
                ListOfincidence[i].add(k);
                break;
              }
            }
          }
          if (tableData[i][j] == 2) {
            ListOfincidence[i].add(i);
          }
        }
      }

      //print(ListOfincidence);

      if (ListOfincidence.isEmpty) {
        print('suka pustoy spisok');
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultPage(
              adjacencyMatrix: getAdjacencyMatrix(ListOfincidence),
              newAdjacencyMatrix:
                  orderFunction(getAdjacencyMatrix(ListOfincidence)),
              renames: getRenames(getAdjacencyMatrix(ListOfincidence)),
              incidenceMatrix: getIncidenceMatrix(ListOfincidence)),
        ),
      );
    } catch (e) {}
  }
}
