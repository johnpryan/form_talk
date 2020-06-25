import 'package:quiver/core.dart';

import 'grade.dart';

class Climb {
  String name;
  Grade grade;
  DateTime date;

  Climb(this.name, this.grade, this.date);

  Climb.empty()
      : name = '',
        date = DateTime.now(),
        grade = Grade.yds('5.8');

  Climb clone() => Climb(name, grade, date);

  void copyTo(Climb other) {
    other.name = name;
    other.grade = grade;
    other.date = date;
  }

  operator ==(Object other) {
    return other is Climb && other.name == name && other.grade == grade &&
        other.date == date;
  }

  int get hashCode => hash3(name, grade, date);

  String toString() {
    return 'Climb: $name $grade $date';
  }
}
