import 'package:flutter/foundation.dart';

@immutable
class CourseConstraints {
  final int maxStatics;
  final int minSigns;
  final int maxSigns;

  const CourseConstraints({
    required this.maxStatics,
    required this.minSigns,
    required this.maxSigns,
  });
}

const Map<int, CourseConstraints> courseConstraints = {
  1: CourseConstraints(maxStatics: 6, minSigns: 10, maxSigns: 12),
  2: CourseConstraints(maxStatics: 8, minSigns: 12, maxSigns: 15),
  3: CourseConstraints(maxStatics: 8, minSigns: 12, maxSigns: 15),
  4: CourseConstraints(maxStatics: 12, minSigns: 15, maxSigns: 17),
  5: CourseConstraints(maxStatics: 12, minSigns: 15, maxSigns: 17),
  6: CourseConstraints(maxStatics: 16, minSigns: 16, maxSigns: 18),
};
