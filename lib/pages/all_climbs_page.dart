import 'package:flutter/material.dart';

import '../models/climb.dart';
import '../models/grade.dart';
import '../widgets/climb_tile.dart';

class AllClimbsPage extends StatefulWidget {
  @override
  _AllClimbsPageState createState() => _AllClimbsPageState();
}

class _AllClimbsPageState extends State<AllClimbsPage> {
  final List<Climb> climbs = <Climb>[
    Climb('Nine Gallon Buckets', Grade.yds('5.10c'), DateTime(2020, 6, 20)),
    Climb('Katina', Grade.fr('6a'), DateTime(2020, 6, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _editClimb(),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ClimbTile(
            climb: climbs[index],
            onTap: () => _editClimb(climbs[index]),
          );
        },
        itemCount: climbs.length,
      ),
    );
  }

  Future _editClimb([Climb climb]) async {}
}
