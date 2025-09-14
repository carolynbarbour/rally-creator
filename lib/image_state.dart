import 'package:flutter/material.dart';

@immutable
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
}

@immutable
class ImageState {
  final String id;
  final SignInfo sign;
  final Matrix4 matrix;
  final double size;

  const ImageState({
    required this.id,
    required this.sign,
    required this.matrix,
    required this.size,
  });

  String get assetPath => sign.assetPath;
  String get name => sign.name;
  String get number => sign.number;

  bool get isCounted {
    return number.isNotEmpty && int.tryParse(number) != null;
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
