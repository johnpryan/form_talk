import 'package:quiver/core.dart';

/// Represents a climbing grade. Supports YDS and FR grading systems.
///
/// Source:
/// http://www.alpinist.com/p/climbing_notes/grades
class Grade {
  final int _raw;
  final GradeType type;

  /// Creates a Grade using the Yosemite Decimal system. [grade] is the same
  /// format returned by [toHumanReadableString] (e.g. '5.10a').
  Grade.yds(String grade)
      : _raw = _yds.entries.firstWhere((entry) => entry.value == grade).key,
        type = GradeType.YDS;

  /// Creates a Grade using the French numerical system. [grade] is the same
  /// format returned by [toHumanReadableString] (e.g. '6a').
  Grade.fr(String grade)
      : _raw = _fr.entries.firstWhere((entry) => entry.value == grade).key,
        type = GradeType.FR;

  Grade._fromRaw(this._raw, this.type);

  String toHumanReadableString() {
    switch (type) {
      case GradeType.FR:
        return _fr[_raw];
      case GradeType.YDS:
      default:
        return _yds[_raw];
    }
  }

  String toString() {
    return 'Grade ${toHumanReadableString()} ($type)';
  }

  Grade toType(GradeType type) {
    return Grade._fromRaw(_raw, type);
  }

  bool operator ==(Object other) =>
      other is Grade && other._raw == _raw && other.type == type;

  int get hashCode => hash2(_raw, type);

  static Iterable<String> listGrades(GradeType type) {
    if (type == GradeType.FR) {
      return _fr.values;
    }

    return _yds.values;
  }
}

enum GradeType {
  YDS,
  FR,
}

// Yosemite Decimal System lookup table
const Map<int, String> _yds = {
  0: '5.2',
  1: '5.3',
  2: '5.4',
  3: '5.5',
  4: '5.6',
  5: '5.7',
  6: '5.8',
  7: '5.9',
  8: '5.10a',
  9: '5.10b',
  10: '5.10c',
  11: '5.10d',
  12: '5.11a',
  13: '5.11b',
  14: '5.11c',
  15: '5.11d',
  16: '5.12a',
  17: '5.12b',
  18: '5.12c',
  19: '5.12d',
  20: '5.13a',
  21: '5.13b',
  22: '5.13c',
  23: '5.13d',
  24: '5.14a',
  25: '5.14b',
  26: '5.14c',
  27: '5.14d',
};

// French numerical system
const Map<int, String> _fr = {
  0: '1',
  1: '2',
  2: '3',
  3: '4',
  4: '4',
  5: '4',
  6: '5a',
  7: '5b',
  8: '5c',
  9: '6a',
  10: '6a+',
  11: '6b',
  12: '6b+',
  13: '6c',
  14: '6c+',
  15: '7a',
  16: '7a+',
  17: '7b',
  18: '7b+',
  19: '7c',
  20: '7c+',
  21: '8a',
  22: '8a+',
  23: '8b',
  24: '8b+',
  25: '8c',
  26: '8c+',
  27: '9a',
};
