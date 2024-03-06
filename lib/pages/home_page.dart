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

  void _compute(BuildContext context) {
    try {
      List<String> savedList = List<String>.from(_listItems);
      //print(savedList);
      List<List<int>> newListOfincidence = List.generate(
          savedList.length, (_) => List<int>.filled(savedList.length, 0));

      for (int i = 0; i < savedList.length; i++) {
        if (savedList[i].isEmpty) {
          print('suka');
          newListOfincidence[i] = List<int>.empty();
        } else {
          newListOfincidence[i] = stringToList(savedList[i]);
        }
      }
      print(newListOfincidence);
      if (newListOfincidence.isEmpty) {
        return;
      }

      for (int j = 0; j < newListOfincidence.length; j++) {
        for (int i = 0; i < newListOfincidence[j].length; i++) {
          newListOfincidence[j][i] -= 1;
        }
      }

      List<List<int>> newAdjacencyMatrix = List.generate(
          savedList.length, (_) => List<int>.filled(savedList.length, 0));

      for (int j = 0; j < newListOfincidence.length; j++) {
        for (int i = 0; i < newListOfincidence[j].length; i++) {
          if (newListOfincidence[j][i] < newListOfincidence.length)
            newAdjacencyMatrix[j][newListOfincidence[j][i]] = 1;
        }
      }

      int arc_count = 0;

      for (int j = 0; j < newListOfincidence.length; j++) {
        for (int i = 0; i < newListOfincidence[j].length; i++) {
          arc_count += 1;
        }
      }

      print(arc_count);

      List<List<int>> newIncidenceMatrix = List.generate(
          savedList.length, (_) => List<int>.filled(arc_count, 0));

      int arc_num = 0;

      for (int j = 0; j < newListOfincidence.length; j++) {
        for (int i = 0; i < newListOfincidence[j].length; i++) {
          if (newListOfincidence[j][i] < newListOfincidence.length) {
            newIncidenceMatrix[newListOfincidence[j][i]][arc_num] = -1;
            newIncidenceMatrix[j][arc_num] = 1;
            if (newListOfincidence[j][i] == j) {
              newIncidenceMatrix[j][arc_num] = 2;
            }
            arc_num += 1;
          }
        }
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultPage(
              adjacencyMatrix: newAdjacencyMatrix,
              incidenceMatrix: newIncidenceMatrix),
        ),
      );
    } catch (e) {}
  }
}
