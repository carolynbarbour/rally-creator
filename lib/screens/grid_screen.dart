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
    final bool isReordering = ref.watch(isReorderingProvider);

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

    // Calculate cell height assuming square cells based on available width
    final double cellDimension = (screenSize.width - 60) / dimensions.width;
    final gridHeight = cellDimension * dimensions.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rally Course'),
      ),
      drawer: ImageSelectionDrawer(
        center: center,
        cellDimension: cellDimension,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top grid numbering
            Row(
              children: [
                const SizedBox(width: 30), // Spacer for left numbering column
                Expanded(
                  child: Row(
                    children: List.generate(
                      dimensions.width.toInt(),
                      (index) => Expanded(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text('${index + 1}'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30), // Spacer for right numbering column
              ],
            ),
            Row(
              children: [
                // Left grid numbering
                SizedBox(
                  width: 30,
                  height: gridHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dimensions.height.toInt(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: cellDimension,
                        alignment: Alignment.center,
                        child: Text('${index + 1}'),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: gridHeight,
                    child: Stack(
                      children: [
                        // The grid background, now non-interactive
                        AbsorbPointer(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: dimensions.width.toInt(),
                            ),
                            itemCount: (dimensions.width * dimensions.height)
                                .toInt(),
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
                                    .applyGestureUpdate(
                                      imageState.id,
                                      tm,
                                      sm,
                                      rm,
                                    );
                              },
                              child: GestureDetector(
                                onTap: () => selectImage(imageState.id),
                                child: SizedBox(
                                  width: imageState.size,
                                  height: imageState.size,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              selectedImageId == imageState.id
                                                  ? Colors.red
                                                  : Colors.transparent,
                                          width: 8.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        imageState.assetPath,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // Right grid numbering
                SizedBox(
                  width: 30,
                  height: gridHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dimensions.height.toInt(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: cellDimension,
                        alignment: Alignment.center,
                        child: Text('${index + 1}'),
                      );
                    },
                  ),
                ),
              ],
            ),
            // List of signs
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref.read(isReorderingProvider.notifier).toggle();
                      },
                      child: Text(isReordering ? 'Done' : 'Edit'),
                    ),
                  ],
                ),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  buildDefaultDragHandles: isReordering,
                  itemCount: placedImages.length,
                  onReorder: (oldIndex, newIndex) {
                    ref
                        .read(placedImagesProvider.notifier)
                        .reorderImages(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final image = placedImages[index];
                    final count = placedImages
                        .take(index + 1)
                        .where((img) => img.isCounted)
                        .length;
                    return Card(
                      key: ValueKey(image.id),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: isReordering
                            ? const SizedBox()
                            : Text(image.isCounted ? '$count' : '–'),
                        title: Text(image.name),
                        subtitle: Text('#${image.number}'),
                        trailing:
                            isReordering ? const Icon(Icons.drag_handle) : null,
                      ),
                    );
                  },
                ),
              ],
            ),
            // Action Buttons
            Container(
              color: Colors.black.withAlpha(128),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_out, color: Colors.white),
                    tooltip: 'Zoom Out',
                    onPressed: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .scaleSelectedImage(scaleFactor: 0.75);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_in, color: Colors.white),
                    tooltip: 'Zoom In',
                    onPressed: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .scaleSelectedImage(scaleFactor: 1.25);
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
