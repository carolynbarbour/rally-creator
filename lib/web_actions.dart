import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

import 'course_state.dart';

void downloadCourseAsJson(String courseName, CourseState courseState) {
  if (kIsWeb) {
    final jsonString = jsonEncode(courseState.toJson());
    final bytes = utf8.encode(jsonString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "$courseName.json")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}

Future<CourseState?> uploadCourseFromJson() async {
  if (kIsWeb) {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.bytes != null) {
      final bytes = result.files.single.bytes!;
      final jsonString = utf8.decode(bytes);
      final jsonMap = jsonDecode(jsonString);
      return CourseState.fromJson(jsonMap);
    }
  }
  return null;
}
