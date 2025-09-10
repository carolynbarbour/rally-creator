import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/image_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

const double initialImageSize = 150.0;

@riverpod
class GridDimensions extends _$GridDimensions {
  @override
  Size build() {
    return const Size(10, 10);
  }

  void setDimensions(Size newSize) {
    state = newSize;
  }
}

@riverpod
class Level extends _$Level {
  @override
  int build() {
    return 1;
  }

  void setLevel(int newLevel) {
    state = newLevel;
  }
}

@riverpod
class SelectedImageId extends _$SelectedImageId {
  @override
  String? build() {
    return null;
  }

  void select(String id) {
    state = id;
  }

  void deselect() {
    state = null;
  }
}

@riverpod
class History extends _$History {
  @override
  List<List<ImageState>> build() {
    return [];
  }

  void addState(List<ImageState> imageState) {
    state = [...state, imageState];
  }

  void undo() {
    if (state.isEmpty) return;

    final previousState = state.removeLast();
    ref.read(placedImagesProvider.notifier).setImages(previousState);
  }
}

@riverpod
class PlacedImages extends _$PlacedImages {
  @override
  List<ImageState> build() {
    return [];
  }

  void _addToHistory() {
    ref.read(historyProvider.notifier).addState(state);
  }

  void addImage(String url, Offset center) {
    _addToHistory();
    final newImage = ImageState(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      url: url,
      matrix: Matrix4.translationValues(
        center.dx - (initialImageSize / 2),
        center.dy - (initialImageSize / 2),
        0,
      ),
    );
    state = [...state, newImage];
    ref.read(selectedImageIdProvider.notifier).select(newImage.id);
  }

  void updateImageMatrix(String id, Matrix4 matrix) {
    _addToHistory();
    state = [
      for (final image in state)
        if (image.id == id) image.copyWith(matrix: matrix) else image,
    ];
  }

  void rotateSelectedImage() {
    final selectedId = ref.read(selectedImageIdProvider);
    if (selectedId == null) return;

    _addToHistory();

    state = [
      for (final image in state)
        if (image.id == selectedId)
          image.copyWith(matrix: image.matrix.clone()..rotateZ(pi / 4))
        else
          image,
    ];
  }

  void deleteSelectedImage() {
    final selectedId = ref.read(selectedImageIdProvider);
    if (selectedId == null) return;

    _addToHistory();

    state = state.where((image) => image.id != selectedId).toList();
    ref.read(selectedImageIdProvider.notifier).deselect();
  }

  void setImages(List<ImageState> images) {
    state = images;
  }
}
