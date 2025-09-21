import 'dart:convert';

import 'package:myapp/course_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_courses_provider.g.dart';

@riverpod
class SavedCourses extends _$SavedCourses {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<String>> build() async {
    final prefs = await _getPrefs();
    return prefs.getKeys().toList();
  }

  Future<void> saveCourse(String name, CourseState course) async {
    final prefs = await _getPrefs();
    final courseJson = course.toJson();
    await prefs.setString(name, jsonEncode(courseJson));
    state = AsyncValue.data(prefs.getKeys().toList());
  }

  Future<CourseState?> loadCourse(String name) async {
    final prefs = await _getPrefs();
    final courseJsonString = prefs.getString(name);
    if (courseJsonString == null) {
      return null;
    }
    final courseJson = jsonDecode(courseJsonString) as Map<String, dynamic>;
    return CourseState.fromJson(courseJson);
  }

  Future<void> deleteCourse(String name) async {
    final prefs = await _getPrefs();
    await prefs.remove(name);
    state = AsyncValue.data(prefs.getKeys().toList());
  }
}
