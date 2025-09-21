// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseState _$CourseStateFromJson(Map<String, dynamic> json) => CourseState(
  images: (json['images'] as List<dynamic>)
      .map((e) => ImageState.fromJson(e as Map<String, dynamic>))
      .toList(),
  dimensions: _sizeFromJson(json['dimensions'] as Map<String, dynamic>),
  title: json['title'] as String,
);

Map<String, dynamic> _$CourseStateToJson(CourseState instance) =>
    <String, dynamic>{
      'images': instance.images,
      'dimensions': _sizeToJson(instance.dimensions),
      'title': instance.title,
    };
