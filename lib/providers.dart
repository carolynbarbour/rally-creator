import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/rally_signs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

part 'providers.g.dart';

final databaseProvider = Provider<FirebaseDatabase>((ref) {
  return FirebaseDatabase.instance;
});

@riverpod
Map<int, List<SignInfo>> signsByLevel(ref) {
  return groupBy(rallySigns, (sign) => sign.level);
}

@Riverpod(keepAlive: true)
class GridDimensions extends _$GridDimensions {
  @override
  Size build() => const Size(10, 10);

  void setDimensions(Size newDimensions) {
    state = newDimensions;
  }
}

@riverpod
class History extends _$History {
  @override
  List<List<ImageState>> build() {
    return [];
  }

  void record(List<ImageState> imageStates) {
    state = [...state, imageStates];
  }

  void undo() {
    if (state.isEmpty) {
      return;
    }
    final previousState = state.last;
    state = state.sublist(0, state.length - 1);
    ref.read(placedImagesProvider.notifier).loadState(previousState);
  }
}

@riverpod
class IsReordering extends _$IsReordering {
  List<ImageState>? _originalImageState;

  @override
  bool build() => false;

  void toggle() {
    state = !state;
    if (state) {
      // Entering reorder mode, save the current state.
      _originalImageState = ref.read(placedImagesProvider);
    } else {
      // Exiting reorder mode, check if we need to add to history.
      final currentState = ref.read(placedImagesProvider);
      if (_originalImageState != null &&
          !const DeepCollectionEquality().equals(
            _originalImageState,
            currentState,
          )) {
        ref.read(historyProvider.notifier).record(_originalImageState!);
      }
      _originalImageState = null;
    }
  }
}

@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  @override
  List<ImageState> build() => [];

  void loadState(List<ImageState> newState) {
    state = newState;
  }

  void _addToHistory() {
    ref.read(historyProvider.notifier).record(state);
  }

  void addImage(SignInfo sign, Offset center, double size) {
    _addToHistory();
    final newImage = ImageState(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sign: sign,
      matrix: Matrix4.translationValues(
        center.dx - size / 2,
        center.dy - size / 2,
        sign.assetPath.contains('base') ? -1.0 : 0, // Bases below other signs,
      ),
      size: size,
    );
    state = [...state, newImage];
  }

  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = [...state];
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }

  void applyGestureUpdate(
    String id,
    Matrix4 translationDelta,
    Matrix4 scaleDelta,
    Matrix4 rotationDelta,
  ) {
    _addToHistory();
    state = [
      for (final image in state)
        if (image.id == id)
          image.copyWith(
            matrix:
                translationDelta * rotationDelta * scaleDelta * image.matrix,
          )
        else
          image,
    ];
  }

  void updateImageMatrix(String id, Matrix4 matrix) {
    _addToHistory();
    state = [
      for (final image in state)
        if (image.id == id) image.copyWith(matrix: matrix) else image,
    ];
  }

  void rotateSelectedImage({bool clockwise = true}) {
    final selectedId = ref.read(selectedImageIdProvider);
    if (selectedId == null) return;

    _addToHistory();
    final angle = clockwise ? math.pi / 2 : -math.pi / 2;

    state = state.map((image) {
      if (image.id == selectedId) {
        final M = image.matrix;
        final centerLocal = vector.Vector3(image.size / 2, image.size / 2, 0);
        final C = M.transform3(centerLocal);

        final rotationMatrix = Matrix4.rotationZ(angle);
        final transform =
            Matrix4.translation(C) * rotationMatrix * Matrix4.translation(-C);

        final newMatrix = transform * M;

        return image.copyWith(matrix: newMatrix);
      } else {
        return image;
      }
    }).toList();
  }

  void scaleSelectedImage({required double scaleFactor}) {
    final selectedId = ref.read(selectedImageIdProvider);
    if (selectedId == null) return;

    _addToHistory();

    state = state.map((image) {
      if (image.id == selectedId) {
        final M = image.matrix;
        final centerLocal = vector.Vector3(image.size / 2, image.size / 2, 0);
        final C = M.transform3(centerLocal);

        final scaleMatrix = Matrix4.identity()
          ..scaleByVector3(vector.Vector3(scaleFactor, scaleFactor, 1.0));
        final transform =
            Matrix4.translation(C) * scaleMatrix * Matrix4.translation(-C);

        final newMatrix = transform * M;

        return image.copyWith(matrix: newMatrix);
      } else {
        return image;
      }
    }).toList();
  }

  void deleteSelectedImage() {
    final selectedId = ref.read(selectedImageIdProvider);
    if (selectedId == null) return;

    _addToHistory();
    state = state.where((image) => image.id != selectedId).toList();
    ref.read(selectedImageIdProvider.notifier).select(null);
  }
}

@riverpod
class SelectedImageId extends _$SelectedImageId {
  @override
  String? build() => null;

  void select(String? id) {
    state = id;
  }
}

@Riverpod(keepAlive: true)
class AppTitle extends _$AppTitle {
  @override
  String build() {
    return 'Rally Course';
  }

  void setTitle(String newTitle) {
    state = newTitle;
  }
}
