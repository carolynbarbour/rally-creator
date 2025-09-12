import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:myapp/widgets/image_selection_drawer.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/providers.dart';

class GridScreen extends ConsumerWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size dimensions = ref.watch(gridDimensionsProvider);
    final List<ImageState> placedImages = ref.watch(placedImagesProvider);
    final String? selectedImageId = ref.watch(selectedImageIdProvider);

    // Correctly calculate the center of the Scaffold body
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bodyHeight = screenSize.height - appBarHeight - topPadding;
    final center = Offset(screenSize.width / 2, bodyHeight / 2);

    void selectImage(String id) {
      if (ref.read(selectedImageIdProvider) != id) {
        HapticFeedback.mediumImpact();
        ref.read(selectedImageIdProvider.notifier).select(id);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Rally Course')),
      drawer: ImageSelectionDrawer(center: center),
      body: Stack(
        children: [
          // The grid background, now non-interactive
          AbsorbPointer(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: dimensions.width.toInt(),
              ),
              itemCount: dimensions.width.toInt() * dimensions.height.toInt(),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                  ),
                );
              },
            ),
          ),
          // The interactive images, now correctly layered
          ...placedImages.map((imageState) {
            return Transform(
              transform: imageState.matrix,
              child: MatrixGestureDetector(
                onMatrixUpdate: (m, tm, sm, rm) {
                  selectImage(imageState.id);
                  ref
                      .read(placedImagesProvider.notifier)
                      .updateImageMatrix(imageState.id, m);
                },
                child: GestureDetector(
                  onTap: () => selectImage(imageState.id),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImageId == imageState.id
                            ? Colors.red
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: initialImageSize,
                      height: initialImageSize,
                      child: Image.asset(
                        imageState.assetPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          // Action Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.rotate_90_degrees_ccw,
                      color: Colors.white,
                    ),
                    tooltip: 'Rotate Left',
                    onPressed: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .rotateSelectedImage(clockwise: false);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.rotate_90_degrees_cw,
                      color: Colors.white,
                    ),
                    tooltip: 'Rotate Right',
                    onPressed: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .rotateSelectedImage();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    tooltip: 'Delete',
                    onPressed: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .deleteSelectedImage();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.undo, color: Colors.white),
                    tooltip: 'Undo',
                    onPressed: () {
                      ref.read(historyProvider.notifier).undo();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
