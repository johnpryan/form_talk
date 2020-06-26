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
  final _formKey = GlobalKey<FormState>();
  Climb _draft;

  void initState() {
    super.initState();

    // Clone a new copy to edit.
    _draft = widget.climb.clone();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_draft == widget.climb) {
          return true;
        }

        // Hide the on-screen keyboard permanently.
        FocusManager.instance.primaryFocus.unfocus();

        // If there are unsaved edits, show a dialog
        var discard = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Discard changes?'),
              actions: [
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Discard',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        );

        return discard;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                var valid = _formKey.currentState.validate();
                if (!valid) {
                  return;
                }
                Navigator.of(context).pop(_draft);
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
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
                    validator: (s) {
                      if (s.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
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
                    validator: (dateTime) {
                      if (dateTime.isAfter(DateTime.now())) {
                        return 'Please select a date in the past.';
                      }
                      return null;
                    },
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
      ),
    );
  }
}
