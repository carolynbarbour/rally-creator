import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/image_state.dart';

part 'course_state.g.dart';

@JsonSerializable()
class CourseState {
  final List<ImageState> images;
  @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
  final Size dimensions;
  final String title;

  CourseState({
    required this.images,
    required this.dimensions,
    required this.title,
  });

  factory CourseState.fromJson(Map<String, dynamic> json) =>
      _$CourseStateFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStateToJson(this);
}

Size _sizeFromJson(Map<String, dynamic> json) {
  return Size(json['width'] as double, json['height'] as double);
}

Map<String, dynamic> _sizeToJson(Size size) {
  return {'width': size.width, 'height': size.height};
}
