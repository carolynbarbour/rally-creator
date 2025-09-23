import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/pdf_generator.dart';
import 'package:myapp/widgets/grid.dart';
import 'package:myapp/widgets/image_button_row.dart';
import 'package:myapp/widgets/image_selection_drawer.dart';
import 'package:myapp/image_state.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets/sign_reorderable_list.dart';
import 'package:screenshot/screenshot.dart';

class GridScreen extends ConsumerStatefulWidget {
  const GridScreen({super.key});

  @override
  ConsumerState<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends ConsumerState<GridScreen> {
  final _gridKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size dimensions = ref.watch(gridDimensionsProvider);
    final List<ImageState> placedImages = ref.watch(placedImagesProvider);
    final String? selectedImageId = ref.watch(selectedImageIdProvider);
    final bool isReordering = ref.watch(isReorderingProvider);
    final screenshotController = ScreenshotController();

    final screenSize = MediaQuery.of(context).size;

    // Calculate cell height assuming square cells based on available width
    final double cellDimension = (screenSize.width - 60) / dimensions.width;
    final gridHeight = cellDimension * dimensions.height;

    final String appTitle = ref.watch(appTitleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => context.push('/saved'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
          // IconButton(
          //   icon: const Icon(Icons.undo),
          //   onPressed: () => ref.read(historyProvider.notifier).undo(),
          // ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => generateAndPrintPdf(
              placedImages,
              dimensions,
              appTitle,
              screenshotController,
              gridHeight,
              cellDimension,
            ),
          ),
        ],
      ),
      drawer: ImageSelectionDrawer(
        gridKey: _gridKey,
        cellDimension: cellDimension,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              Grid(
                key: _gridKey,
                dimensions: dimensions,
                gridHeight: gridHeight,
                cellDimension: cellDimension,
                placedImages: placedImages,
                selectedImageId: selectedImageId,
                isReordering: isReordering,
              ),
              SignReorderableList(
                isReordering: isReordering,
                placedImages: placedImages,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withAlpha(128),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ImageButtonRow(),
            ),
          ),
        ],
      ),
    );
  }
}
