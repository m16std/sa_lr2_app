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
      home: DynamicListPage(),
    );
  }
}

class DynamicListPage extends StatefulWidget {
  @override
  _DynamicListPageState createState() => _DynamicListPageState();
}

class _DynamicListPageState extends State<DynamicListPage> {
  List<String> _listItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Множество правых инциденций'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Введите вершины в которые можно \nнепос­редственно попасть из этой вершины',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 9, right: 9, bottom: 10),
                  child: ListTile(
                    tileColor: const Color.fromARGB(31, 163, 162, 177),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 196, 194, 235),
                        child: Text((index + 1).toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal))),
                    title: TextFormField(
                      decoration: InputDecoration(
                        //icon: Icon(Icons.person),
                        hintText: 'Куда можно попасть',
                        filled: true,
                        fillColor: const Color.fromARGB(0, 53, 22, 22),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 141, 105, 240)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      initialValue: _listItems[index],
                      onChanged: (value) {
                        _listItems[index] = value;
                      },
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _addItemToList,
                child: const Text('Добавить'),
              ),
              ElevatedButton(
                onPressed: _removeItem,
                child: const Text('Удалить'),
              ),
              ElevatedButton(
                onPressed: () {
                  _compute(context);
                },
                child: const Text('Перевести'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addItemToList() {
    setState(() {
      _listItems.add('');
    });
  }

  void _removeItem() {
    setState(() {
      if (_listItems.isNotEmpty) {
        _listItems.removeAt(_listItems.length - 1);
      }
    });
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
    for (int i = 0; i < n; i++) {
      bufer = position[a];
      position[a] = position[b];
      position[b] = bufer;
    }
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

      last_renamed.clear;

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
      List<String> savedList = List<String>.from(_listItems);

      List<List<int>> ListOfincidence = List.generate(
          savedList.length, (_) => List<int>.filled(savedList.length, 0));

      for (int i = 0; i < savedList.length; i++) {
        if (savedList[i].isEmpty) {
          print('blyat');
          ListOfincidence[i] = List<int>.empty();
        } else {
          ListOfincidence[i] = stringToList(savedList[i]);
        }
      }

      //print(ListOfincidence);

      if (ListOfincidence.isEmpty) {
        print('suka pustoy spisok');
        return;
      }

      for (int j = 0; j < ListOfincidence.length; j++) {
        for (int i = 0; i < ListOfincidence[j].length; i++) {
          ListOfincidence[j][i] -= 1;
          //потому что внутри кода мы работаем с нумерацией начиная от нуля
        }
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
