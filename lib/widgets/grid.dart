import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/providers.dart';

class Grid extends ConsumerWidget {
  const Grid({
    super.key,
    required this.dimensions,
    required this.gridHeight,
    required this.cellDimension,
    required this.placedImages,
    required this.selectedImageId,
    required this.isReordering,
  });

  final Size dimensions;
  final double gridHeight;
  final double cellDimension;
  final List<ImageState> placedImages;
  final String? selectedImageId;
  final bool isReordering;

  void selectImage(WidgetRef ref, String id) {
    if (ref.read(selectedImageIdProvider) != id) {
      HapticFeedback.mediumImpact();
      ref.read(selectedImageIdProvider.notifier).select(id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ImageState> numberedSigns = placedImages.where((image) {
      return !image.assetPath.toLowerCase().contains('base') &&
          !image.assetPath.toLowerCase().contains('bonus');
    }).toList();

    return SliverToBoxAdapter(
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
                        final bool isSpecialSign =
                            imageState.assetPath.contains('base') ||
                            imageState.assetPath.contains('bonus');

                        int displayIndex = -1;
                        if (!isSpecialSign) {
                          displayIndex = numberedSigns.indexOf(imageState);
                        }

                        return Transform(
                          transform: imageState.matrix,
                          child: MatrixGestureDetector(
                            onMatrixUpdate: (m, tm, sm, rm) {
                              selectImage(ref, imageState.id);
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
                              onTap: () => selectImage(ref, imageState.id),
                              child: Stack(
                                children: [
                                  SizedBox(
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
                                  if (!isReordering && !isSpecialSign)
                                    Positioned(
                                      top: -6,
                                      right: -10,
                                      child: Chip(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Colors.yellow,
                                        label: Text(
                                          '${displayIndex + 1}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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
        ],
      ),
    );
  }
}
