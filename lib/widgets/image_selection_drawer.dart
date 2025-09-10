import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers.dart';

class ImageSelectionDrawer extends ConsumerWidget {
  final Offset center;

  const ImageSelectionDrawer({super.key, required this.center});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: List.generate(
                6,
                (index) => Tab(text: 'Level ${index + 1}'),
              ),
              onTap: (index) {
                ref.read(levelProvider.notifier).setLevel(index + 1);
              },
            ),
            title: const Text('Levels'),
            automaticallyImplyLeading: false,
          ),
          body: TabBarView(
            children: List.generate(6, (levelIndex) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final imageIndex = (levelIndex * 10) + index;
                  final imageUrl =
                      'https://picsum.photos/150/150?random=$imageIndex';
                  return ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('Image $index'),
                    onTap: () {
                      ref
                          .read(placedImagesProvider.notifier)
                          .addImage(imageUrl, center);
                      Navigator.pop(context); // Close the drawer
                    },
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
