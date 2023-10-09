import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class AppGraph extends StatefulWidget {
  const AppGraph({super.key});

  @override
  State<AppGraph> createState() => _AppGraphState();
}

class _AppGraphState extends State<AppGraph> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    List<Team> teams = [
      Team("1", AssetImage('assets/images/Logo.png'), "Beavers", 1),
      Team("2", AssetImage('assets/images/Logo.png'), "Bulls", 3),
      Team("3", AssetImage('assets/images/Logo.png'), "Cats", 4),
      Team("4", AssetImage('assets/images/Logo.png'), "Guns", 4),
    ];

    var fights = [[1,2],[3,4],[1,3], [1,1]];

    for(var fight in fights){
      if(fight[0] == fight[1]) graph.addEdge(Node.Id(fight[0]), Node.Id(fight[1]));
      graph.addEdge(Node.Id(fight[0]), Node.Id(fight[1]));
    }


    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }


  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        constrained: false,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
          paint: Paint()
            ..color = Colors.green
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            // I can decide what widget should be shown here based on the id
            var a = node.key!.value as int?;

            return rectangleWidget(a);
          },
        )
    );
  }



  Widget rectangleWidget(List<Team> teams) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child:  SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text("image"),
                  Text("Name"),
                  Text("Score"),
                ],),
                Divider(
                  height: 20,
                  thickness: 5,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text("image"),
                  Text("Name"),
                  Text("Score"),
                ],),
            ],),)),
    );
  }
}

class Team {
  Team(this.id, this.Logo, this.Name, this.Score);

  late String id;
  final AssetImage Logo;
  final String Name;
  final int Score;
}
