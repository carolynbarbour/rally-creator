import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/level_selection_provider.dart';
import 'package:myapp/providers.dart';

class ImageSelectionDrawer extends ConsumerWidget {
  const ImageSelectionDrawer({
    super.key,
    required this.gridKey,
    required this.cellDimension,
  });

  final GlobalKey gridKey;
  final double cellDimension;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signsByLevel = ref.watch(signsByLevelProvider);
    final courseLevel = ref.watch(levelProvider);

    final levelKeys =
        signsByLevel.keys
            .where((level) => level != 0 && level <= courseLevel)
            .toList()
          ..sort();
    final tabs = <Widget>[
      const Tab(text: 'Base'),
      ...levelKeys.map((level) => Tab(text: 'Level $level')),
    ].toList();

    return Drawer(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: tabs, isScrollable: true),
            title: const Text('Signs'),
            automaticallyImplyLeading: false,
          ),
          body: TabBarView(
            children: [
              // Base Signs
              ListView.builder(
                itemCount: signsByLevel[0]?.length ?? 0,
                itemBuilder: (context, index) {
                  final sign = signsByLevel[0]![index];
                  return ListTile(
                    leading: Image.asset(
                      sign.assetPath,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    title: sign.name.isNotEmpty ? Text(sign.name) : null,
                    subtitle: sign.number.isNotEmpty
                        ? Text('#${sign.number}')
                        : null,
                    onTap: () {
                      final renderObject = gridKey.currentContext
                          ?.findRenderObject();
                      RenderBox? gridBox;
                      if (renderObject is RenderSliverToBoxAdapter) {
                        gridBox = renderObject.child;
                      } else if (renderObject is RenderBox) {
                        gridBox = renderObject;
                      }

                      final center = gridBox != null
                          ? gridBox.localToGlobal(
                              gridBox.size.center(Offset.zero),
                            )
                          : const Offset(100, 100);

                      var newImageSize = customScaling(cellDimension, sign);
                      ref
                          .read(placedImagesProvider.notifier)
                          .addImage(sign, center, newImageSize);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              // Level Signs
              ...levelKeys.map((level) {
                return ListView.builder(
                  itemCount: signsByLevel[level]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final sign = signsByLevel[level]![index];
                    return ListTile(
                      leading: Image.asset(
                        sign.assetPath,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      title: Text(sign.name),
                      subtitle: Text('#${sign.number}'),
                      onTap: () {
                        final renderObject = gridKey.currentContext
                            ?.findRenderObject();
                        RenderBox? gridBox;
                        if (renderObject is RenderSliverToBoxAdapter) {
                          gridBox = renderObject.child;
                        } else if (renderObject is RenderBox) {
                          gridBox = renderObject;
                        }

                        final center = gridBox != null
                            ? gridBox.localToGlobal(
                                gridBox.size.center(Offset.zero),
                              )
                            : const Offset(100, 100);
                        ref
                            .read(placedImagesProvider.notifier)
                            .addImage(sign, center, cellDimension);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  double customScaling(double cellDimension, SignInfo sign) {
    double newImageSize = cellDimension;
    if (sign.assetPath.contains('cone')) {
      if (sign.assetPath.contains('3')) {
        newImageSize = cellDimension * 1.5;
      } else if (sign.assetPath.contains('4')) {
        newImageSize = cellDimension * 2.5;
      }
    } else {
      if (sign.assetPath.contains('jump') || sign.assetPath.contains('hoop')) {
        newImageSize = cellDimension * 6.0;
      } else if (sign.assetPath.contains('distractions')) {
        if (sign.assetPath.contains('recall')) {
          newImageSize = cellDimension * 3.0;
        } else {
          newImageSize = cellDimension * 1.5;
        }
      } else if (sign.assetPath.contains('pole')) {
        newImageSize = cellDimension * 2.0;
      } else if (sign.assetPath.contains('heel')) {
        newImageSize = cellDimension * 4.5;
      }
    }

    return newImageSize;
  }
}
