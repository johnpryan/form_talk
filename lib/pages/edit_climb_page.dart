import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/climb.dart';
import '../models/grade.dart';
import '../widgets/date_form_field.dart';

class EditClimbPage extends StatefulWidget {
  final Climb climb;

  EditClimbPage({
    @required this.climb,
  });

  @override
  _EditClimbPageState createState() => _EditClimbPageState();
}

class _EditClimbPageState extends State<EditClimbPage> {
  Climb _draft;

  void initState() {
    super.initState();

    // Clone a new copy to edit.
    _draft = widget.climb.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Text('Done'),
            onPressed: () {
              Navigator.of(context).pop(_draft);
            },
          ),
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name of the climb...',
                    filled: true,
                  ),
                  initialValue: _draft.name,
                  onChanged: (newValue) {
                    _draft.name = newValue;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                DateFormField(
                  initialValue: _draft.date,
                  onChanged: (newDate) {
                    _draft.date = newDate;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                DropdownButtonFormField<GradeType>(
                  value: _draft.grade.type,
                  decoration: InputDecoration(filled: true),
                  onChanged: (gradeType) {
                    setState(() {
                      _draft.grade = _draft.grade.toType(gradeType);
                    });
                  },
                  items: [
                    ...GradeType.values.map(
                      (type) => DropdownMenuItem<GradeType>(
                        value: type,
                        child: Text(describeEnum(type)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                DropdownButtonFormField<String>(
                  value: _draft.grade.toHumanReadableString(),
                  decoration: InputDecoration(filled: true),
                  onChanged: (gradeString) {
                    if (_draft.grade.type == GradeType.FR) {
                      _draft.grade = Grade.fr(gradeString);
                    } else {
                      _draft.grade = Grade.yds(gradeString);
                    }
                  },
                  items: [
                    ...Grade.listGrades(_draft.grade.type).map(
                      (gradeString) => DropdownMenuItem<String>(
                        value: gradeString,
                        child: Text(gradeString),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
