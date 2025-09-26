import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/rally_signs.dart';

part 'image_state.g.dart';

@JsonSerializable()
class SignInfo {
  final String assetPath;
  final String number;
  final String name;
  final int level;
  final int static;

  const SignInfo({
    required this.assetPath,
    required this.number,
    required this.name,
    required this.level,
    required this.static,
  });

  factory SignInfo.fromJson(Map<String, dynamic> json) =>
      _$SignInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SignInfoToJson(this);
}

@immutable
@JsonSerializable()
class ImageState {
  final String id;
  @JsonKey(fromJson: _signInfoFromJson, toJson: _signInfoToJson)
  final SignInfo sign;
  @JsonKey(fromJson: _matrix4FromJson, toJson: _matrix4ToJson)
  final Matrix4 matrix;
  final double size;

  const ImageState({
    required this.id,
    required this.sign,
    required this.matrix,
    required this.size,
  });

  factory ImageState.fromJson(Map<String, dynamic> json) =>
      _$ImageStateFromJson(json);
  Map<String, dynamic> toJson() => _$ImageStateToJson(this);

  String get assetPath => sign.assetPath;
  String get name => sign.name;
  String get number => sign.number;

  bool get isCounted {
    return number.isNotEmpty &&
        int.tryParse(number) != null &&
        !assetPath.toLowerCase().contains('base');
  }

  ImageState copyWith({
    String? id,
    SignInfo? sign,
    Matrix4? matrix,
    double? size,
  }) {
    return ImageState(
      id: id ?? this.id,
      sign: sign ?? this.sign,
      matrix: matrix ?? this.matrix,
      size: size ?? this.size,
    );
  }
}

Matrix4 _matrix4FromJson(List<dynamic> json) {
  return Matrix4.fromList(json.cast<double>());
}

List<double> _matrix4ToJson(Matrix4 matrix) {
  return matrix.storage.toList();
}

SignInfo _signInfoFromJson(Map<String, dynamic> json) {
  final assetPath = json['assetPath'] as String;

  // Backwards compatibility for old .jpg base signs: convert .jpg base images to .png
  if (assetPath.contains('base') &&
      assetPath.contains('jpg') &&
      !(assetPath.contains('start') ||
          assetPath.contains('bonus') ||
          assetPath.contains('finish'))) {
    final pngAssetPath = assetPath.replaceAll('.jpg', '.png');
    return rallySigns.firstWhere((s) => s.assetPath == pngAssetPath);
  }
  return rallySigns.firstWhere((s) => s.assetPath == assetPath);
}

Map<String, dynamic> _signInfoToJson(SignInfo sign) {
  return {'assetPath': sign.assetPath};
}
