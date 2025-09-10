import 'package:flutter/material.dart';

@immutable
class ImageState {
  final String id;
  final String url;
  final Matrix4 matrix;

  const ImageState({
    required this.id,
    required this.url,
    required this.matrix,
  });

  ImageState copyWith({
    String? id,
    String? url,
    Matrix4? matrix,
  }) {
    return ImageState(
      id: id ?? this.id,
      url: url ?? this.url,
      matrix: matrix ?? this.matrix,
    );
  }
}
