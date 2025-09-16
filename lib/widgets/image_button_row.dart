import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers.dart';

class ImageButtonRow extends ConsumerWidget {
  const ImageButtonRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moreRotations = ref.watch(moreRotationsProvider);
    final angle = moreRotations ? math.pi / 4 : math.pi / 2; // 45 or 90 degrees

    return Row(
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
          icon: const Icon(Icons.rotate_90_degrees_ccw, color: Colors.white),
          tooltip: 'Rotate Left',
          onPressed: () {
            ref
                .read(placedImagesProvider.notifier)
                .rotateSelectedImage(angle: -angle);
          },
        ),
        IconButton(
          icon: const Icon(Icons.rotate_90_degrees_cw, color: Colors.white),
          tooltip: 'Rotate Right',
          onPressed: () {
            ref
                .read(placedImagesProvider.notifier)
                .rotateSelectedImage(angle: angle);
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          tooltip: 'Delete',
          onPressed: () {
            ref.read(placedImagesProvider.notifier).deleteSelectedImage();
          },
        ),
      ],
    );
  }
}
