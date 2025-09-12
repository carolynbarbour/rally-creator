import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers.dart';

class ImageSelectionDrawer extends ConsumerWidget {
  final Offset center;

  const ImageSelectionDrawer({super.key, required this.center});

  Widget _buildImageList(WidgetRef ref, BuildContext context, int level) {
    final imageListProvider = imageAssetsForLevelProvider(level);
    final imageList = ref.watch(imageListProvider);

    return imageList.when(
      data: (images) {
        return ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];
            return ListTile(
              leading: Image.asset(
                image.assetPath,
                scale: 0.5,
                fit: BoxFit.cover,
              ),
              title: Text(image.name),
              onTap: () {
                ref
                    .read(placedImagesProvider.notifier)
                    .addImage(image.assetPath, image.name, center);
                Navigator.pop(context); // Close the drawer
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentLevel = ref.watch(levelProvider);

    return Drawer(
      child: DefaultTabController(
        initialIndex: currentLevel,
        length: 7, // "Base" + 6 levels
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                const Tab(text: 'Base'),
                ...List.generate(6, (index) => Tab(text: 'Level ${index + 1}')),
              ],
              onTap: (index) {
                ref.read(levelProvider.notifier).setLevel(index);
              },
            ),
            title: const Text('Levels'),
            automaticallyImplyLeading: false,
          ),
          body: TabBarView(
            children: List.generate(7, (index) {
              return _buildImageList(ref, context, index);
            }),
          ),
        ),
      ),
    );
  }
}
