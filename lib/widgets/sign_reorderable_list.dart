import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/course_constraints.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/level_selection_provider.dart';
import 'package:myapp/providers.dart';

class SignReorderableList extends ConsumerWidget {
  const SignReorderableList({
    super.key,
    required this.isReordering,
    required this.placedImages,
  });

  void selectImage(WidgetRef ref, String id) {
    if (ref.read(selectedImageIdProvider) != id) {
      HapticFeedback.mediumImpact();
      ref.read(selectedImageIdProvider.notifier).select(id);
    }
  }

  final bool isReordering;
  final List<ImageState> placedImages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalStatic = placedImages
        .where((element) => element.isCounted)
        .fold<int>(0, (sum, image) => sum + image.sign.static);
    final int courseLevel = ref.watch(levelProvider);
    final constraints = courseConstraints[courseLevel]!;
    final totalSigns = placedImages
        .where((element) => element.isCounted)
        .length;

    return SliverToBoxAdapter(
      child: Column(
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
            proxyDecorator: (widget, index, animation) {
              return Material(color: Colors.transparent, child: widget);
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
                  trailing: isReordering ? const Icon(Icons.drag_handle) : null,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
                Text(
                  'Total Statics: $totalStatic / ${constraints.maxStatics}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: totalStatic > constraints.maxStatics
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Signs: $totalSigns (${constraints.minSigns}-${constraints.maxSigns})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        totalSigns < constraints.minSigns ||
                            totalSigns > constraints.maxSigns
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Add padding to the bottom to avoid being obscured by the action bar
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
