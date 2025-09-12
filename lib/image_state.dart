import 'package:flutter/material.dart';

@immutable
class ImageState {
  final String id;
  final String assetPath;
  final String name;
  final Matrix4 matrix;

  const ImageState({
    required this.id,
    required this.assetPath,
    required this.name,
    required this.matrix,
  });

  bool get isCounted {
    return !name.contains('start') &&
        !name.contains('finish') &&
        !name.contains('bonus');
  }

  ImageState copyWith({
    String? id,
    String? assetPath,
    String? name,
    Matrix4? matrix,
  }) {
    return ImageState(
      id: id ?? this.id,
      assetPath: assetPath ?? this.assetPath,
      name: name ?? this.name,
      matrix: matrix ?? this.matrix,
    );
  }
}
