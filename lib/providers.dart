import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/image_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

part 'providers.g.dart';

const double initialImageSize = 150.0;

final databaseProvider = Provider<FirebaseDatabase>((ref) {
  return FirebaseDatabase.instance;
});

@immutable
class ImageAsset {
  final String assetPath;
  final String name;

  const ImageAsset({required this.assetPath, required this.name});
}

List<String> _getImageListForLevel(int level) {
  final List<String> baseImages = [
    'assets/base/bonus.jpg',
    'assets/base/finish.jpg',
    'assets/base/start.jpg',
  ];

  final List<String> level1Images = [
    'assets/level1/001.jpg',
    'assets/level1/002.jpg',
    'assets/level1/003.jpg',
    'assets/level1/004.jpg',
    'assets/level1/005.jpg',
    'assets/level1/006.jpg',
    'assets/level1/007.jpg',
    'assets/level1/008.jpg',
    'assets/level1/009.jpg',
    'assets/level1/010.jpg',
    'assets/level1/011.jpg',
    'assets/level1/012.jpg',
    'assets/level1/013.jpg',
    'assets/level1/014.jpg',
    'assets/level1/015.jpg',
    'assets/level1/016.jpg',
    'assets/level1/017.jpg',
    'assets/level1/018.jpg',
    'assets/level1/019.jpg',
    'assets/level1/020.jpg',
    'assets/level1/021.jpg',
    'assets/level1/022.jpg',
    'assets/level1/bonus.jpg',
    'assets/level1/bonus1.jpg',
    'assets/level1/bonus2.jpg',
    'assets/level1/bonus3.jpg',
  ];

  final List<String> level2Images = [
    'assets/level2/023.jpg',
    'assets/level2/024.jpg',
    'assets/level2/025.jpg',
    'assets/level2/026.jpg',
    'assets/level2/027.jpg',
    'assets/level2/028.jpg',
    'assets/level2/029.jpg',
    'assets/level2/030.jpg',
    'assets/level2/031.jpg',
    'assets/level2/032.jpg',
    'assets/level2/033.jpg',
    'assets/level2/034.jpg',
    'assets/level2/035.jpg',
    'assets/level2/bonus4a.jpg',
    'assets/level2/bonus4b.jpg',
    'assets/level2/bonus5a.jpg',
    'assets/level2/bonus5b.jpg',
  ];

  final List<String> level3Images = [
    'assets/level3/036a.jpg',
    'assets/level3/036b.jpg',
    'assets/level3/037a.jpg',
    'assets/level3/037b.jpg',
    'assets/level3/038.jpg',
    'assets/level3/039.jpg',
    'assets/level3/040.jpg',
    'assets/level3/041.jpg',
    'assets/level3/042.jpg',
    'assets/level3/043.jpg',
    'assets/level3/044a.jpg',
    'assets/level3/044b.jpg',
    'assets/level3/045.jpg',
    'assets/level3/bonus6.jpg',
    'assets/level3/bonus7a.jpg',
    'assets/level3/bonus7b.jpg',
    'assets/level3/bonus8a.jpg',
    'assets/level3/bonus8b.jpg',
  ];

  final List<String> level4Images = [
    'assets/level4/046a.jpg',
    'assets/level4/046b.jpg',
    'assets/level4/047.jpg',
    'assets/level4/048.jpg',
    'assets/level4/049.jpg',
    'assets/level4/050.jpg',
    'assets/level4/051.jpg',
    'assets/level4/052.jpg',
    'assets/level4/053.jpg',
    'assets/level4/054a.jpg',
    'assets/level4/054b.jpg',
    'assets/level4/055.jpg',
    'assets/level4/056a.jpg',
    'assets/level4/056b.jpg',
    'assets/level4/bonus10a.jpg',
    'assets/level4/bonus10b.jpg',
    'assets/level4/bonus9.jpg',
  ];

  final List<String> level5Images = [
    'assets/level5/057a.jpg',
    'assets/level5/057b.jpg',
    'assets/level5/058.jpg',
    'assets/level5/059.jpg',
    'assets/level5/060.jpg',
    'assets/level5/061.jpg',
    'assets/level5/062.jpg',
    'assets/level5/bonus11.jpg',
    'assets/level5/bonus12a.jpg',
    'assets/level5/bonus12b.jpg',
  ];

  final List<String> level6Images = [
    'assets/level6/063a.jpg',
    'assets/level6/063b.jpg',
    'assets/level6/064a.jpg',
    'assets/level6/064b.jpg',
    'assets/level6/065a.jpg',
    'assets/level6/065b.jpg',
    'assets/level6/066a.jpg',
    'assets/level6/066b.jpg',
    'assets/level6/067.jpg',
    'assets/level6/068.jpg',
    'assets/level6/bonus13.jpg',
    'assets/level6/bonus14.jpg',
    'assets/level6/bonus15.jpg',
  ];

  final allLevels = [
    baseImages,
    level1Images,
    level2Images,
    level3Images,
    level4Images,
    level5Images,
    level6Images,
  ];

  return allLevels[level];
}

@riverpod
Future<List<ImageAsset>> imageAssetsForLevel(ref, int level) async {
  final imageList = _getImageListForLevel(level);
  final assets = <ImageAsset>[];
  for (final assetPath in imageList) {
    final name = assetPath.split('/').last.replaceAll('.jpg', '');
    assets.add(ImageAsset(assetPath: assetPath, name: name));
  }
  return assets;
}

@Riverpod(keepAlive: true)
class Level extends _$Level {
  @override
  int build() => 0;

  void setLevel(int newLevel) {
    state = newLevel;
  }
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
    ref.read(placedImagesProvider.notifier).state = previousState;
  }
}

@riverpod
class PlacedImages extends _$PlacedImages {
  @override
  List<ImageState> build() => [];

  void _addToHistory() {
    ref.read(historyProvider.notifier).record(state);
  }

  void addImage(String assetPath, String name, Offset center) {
    _addToHistory();
    final newImage = ImageState(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetPath: assetPath,
      name: name,
      matrix: Matrix4.translationValues(
        center.dx - initialImageSize / 2,
        center.dy - initialImageSize / 2,
        0,
      ),
    );
    state = [...state, newImage];
  }

  void applyGestureUpdate(String id, Matrix4 translationDelta, Matrix4 scaleDelta, Matrix4 rotationDelta) {
    _addToHistory();
    state = [
      for (final image in state)
        if (image.id == id) 
          image.copyWith(matrix: translationDelta * rotationDelta * scaleDelta * image.matrix)
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
        final translation = vector.Vector3.zero();
        final rotation = vector.Quaternion.identity();
        final scale = vector.Vector3.zero();
        image.matrix.decompose(translation, rotation, scale);

        final rotationUpdate = vector.Quaternion.axisAngle(
          vector.Vector3(0, 0, 1),
          angle,
        );
        final newRotation = rotation * rotationUpdate;

        final newMatrix = Matrix4.compose(translation, newRotation, scale);

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
        final translation = vector.Vector3.zero();
        final rotation = vector.Quaternion.identity();
        final scale = vector.Vector3.zero();
        image.matrix.decompose(translation, rotation, scale);

        scale.scale(scaleFactor);

        final newMatrix = Matrix4.compose(translation, rotation, scale);

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
