import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'app_graph.dart';

class AppGraph extends StatefulWidget {
  const AppGraph({super.key});

  @override
  State<AppGraph> createState() => _AppGraphState();
}

class _AppGraphState extends State<AppGraph> {
  final Graph graph = Graph()
    ..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  List<Team> teams = [
    Team("1", AssetImage('assets/images/Logo.png'), "Beavers", 1),
    Team("2", AssetImage('assets/images/Logo.png'), "Bulls", 3),
    Team("3", AssetImage('assets/images/Logo.png'), "Cats", 4),
    Team("4", AssetImage('assets/images/Logo.png'), "Guns", 4),
  ];

  late final List<Fight> fights;


  @override
  void initState() {
    super.initState();

    fights = [
      Fight("0", teams[0], teams[1]),
      Fight("1", teams[2], teams[3]),
      Fight("2", teams[0], teams[2]),
      Fight("3", teams[0], teams[0]),
    ];

    graph.addEdge(Node.Id(fights[0].id), Node.Id(fights[2].id));
    graph.addEdge(Node.Id(fights[1].id), Node.Id(fights[2].id));
    graph.addEdge(Node.Id(fights[2].id), Node.Id(fights[3].id));



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
          algorithm: BuchheimWalkerAlgorithm(
              builder, TreeEdgeRenderer(builder)),
          paint: Paint()
            ..color = Colors.green
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            // I can decide what widget should be shown here based on the id
            var id = node.key!.value as String?;

            List<Team> thisTable = [
              fights.firstWhere((element) => element.id == id).teamA,
              fights.firstWhere((element) => element.id == id).teamB
            ];

            return rectangleWidget(thisTable);
          },
        )
    );
  }


  Widget rectangleWidget(List<Team> teams) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: getTable(teams),),)
    );
  }

  List<Widget>  getTable(List<Team> teams) {
    List<Widget> teamWidgets = [];
    for (Team team in teams) {
      teamWidgets.add(
          InkWell(
            onTap: () {},
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: team.Logo),
                Text(team.Name),
                Text(team.Score.toString()),
              ],),)
      );

      teamWidgets.add(
          const Divider(
            height: 20,
            thickness: 5,
            color: Colors.black,
          )
      );
    }
    for (var i = 0; i < teams.length; i++) {

    }
    return teamWidgets;
  }
}

class Fight {
  Fight(this.id, this.teamA, this.teamB);

  late String id;
  final Team teamA;
  final Team teamB;
}

class Team {
  Team(this.id, this.Logo, this.Name, this.Score);

  late String id;
  final AssetImage Logo;
  final String Name;
  final int Score;
}
