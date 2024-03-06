import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  final List<List<int>>? adjacencyMatrix;

  const TreeViewPage({super.key, this.adjacencyMatrix});
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Просмотр графа'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                //margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                  //constrained: false,
                  //boundaryMargin: EdgeInsets.all(10),
                  minScale: 0.1,
                  maxScale: 10.0,
                  child: GraphView(
                    graph: graph,
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    algorithm: FruchtermanReingoldAlgorithm(),
                    builder: (Node node) {
                      var a = node.key!.value as int;
                      return rectangleWidget(a + 1);
                    },
                  )),
            ),
          ],
        ));
  }

  Widget rectangleWidget(int a) {
    return InkWell(
      child: Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(94, 83, 51, 160), spreadRadius: 0),
            ],
          ),
          child: Center(
              child: Text(
            '$a',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ))),
    );
  }

  final Graph graph = Graph();

  @override
  void initState() {
    List<Node> ListNode = List.generate(
        widget.adjacencyMatrix!.length, (int index) => Node.Id(index));

    // Создаем ребра на основе таблицы смежности
    for (int i = 0; i < widget.adjacencyMatrix!.length; i++) {
      for (int j = 0; j < widget.adjacencyMatrix![i].length; j++) {
        if (widget.adjacencyMatrix![i][j] == 1) {
          // Добавляем ребро от i-й вершины к j-й вершине
          if (i == j) continue;
          graph.addEdge(ListNode[i], ListNode[j]);
        }
      }
    }
    var builder = FruchtermanReingoldAlgorithm();
  }
}
