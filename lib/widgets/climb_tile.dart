import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/climb.dart';

class ClimbTile extends StatelessWidget {
  final Climb climb;
  final VoidCallback onTap;

  ClimbTile({
    @required this.climb,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(climb.name),
      subtitle: Text(DateFormat.yMd().format(climb.date)),
      trailing: Text(climb.grade.toHumanReadableString()),
      onTap: onTap,
    );
  }
}
