// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInfo _$SignInfoFromJson(Map<String, dynamic> json) => SignInfo(
  assetPath: json['assetPath'] as String,
  number: json['number'] as String,
  name: json['name'] as String,
  level: (json['level'] as num).toInt(),
  static: (json['static'] as num).toInt(),
);

Map<String, dynamic> _$SignInfoToJson(SignInfo instance) => <String, dynamic>{
  'assetPath': instance.assetPath,
  'number': instance.number,
  'name': instance.name,
  'level': instance.level,
  'static': instance.static,
};

ImageState _$ImageStateFromJson(Map<String, dynamic> json) => ImageState(
  id: json['id'] as String,
  sign: _signInfoFromJson(json['sign'] as Map<String, dynamic>),
  matrix: _matrix4FromJson(json['matrix'] as List),
  size: (json['size'] as num).toDouble(),
);

Map<String, dynamic> _$ImageStateToJson(ImageState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sign': _signInfoToJson(instance.sign),
      'matrix': _matrix4ToJson(instance.matrix),
      'size': instance.size,
    };
