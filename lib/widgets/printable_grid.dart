import 'package:flutter/material.dart';
import 'package:myapp/image_state.dart';

class PrintableGrid extends StatelessWidget {
  const PrintableGrid({
    super.key,
    required this.dimensions,
    required this.gridHeight,
    required this.cellDimension,
    required this.placedImages,
  });

  final Size dimensions;
  final double gridHeight;
  final double cellDimension;
  final List<ImageState> placedImages;

  @override
  Widget build(BuildContext context) {
    final numberedSigns = placedImages.where((image) {
      final lowercasedAssetPath = image.assetPath.toLowerCase();
      return !lowercasedAssetPath.contains('base') &&
          !lowercasedAssetPath.contains('bonus');
    }).toList();

    return Column(
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
              child: Column(
                children: List.generate(
                  dimensions.height.toInt(),
                  (index) => Container(
                    height: cellDimension,
                    alignment: Alignment.center,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: gridHeight,
                child: Stack(
                  children: [
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
                                      color: Colors.transparent,
                                      width: 8.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    imageState.assetPath,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (!isSpecialSign)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
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
              child: Column(
                children: List.generate(
                  dimensions.height.toInt(),
                  (index) => Container(
                    height: cellDimension,
                    alignment: Alignment.center,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
