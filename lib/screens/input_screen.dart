import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/level_selection_provider.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/saved_courses_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/web_actions.dart';

class InputScreen extends ConsumerStatefulWidget {
  const InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = ref.read(appTitleProvider);
  }

  @override
  Widget build(BuildContext context) {
    final int courseLevel = ref.watch(levelProvider);
    final savedCourses = ref.watch(savedCoursesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Grid Dimensions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Course Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _widthController,
              decoration: const InputDecoration(labelText: 'Width (8-20)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (8-20)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<int>(
              value: courseLevel,
              items: List.generate(6, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('Level ${index + 1}'),
                );
              }),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  ref.read(levelProvider.notifier).setLevel(newValue);
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(appTitleProvider.notifier)
                    .setTitle(_titleController.text);
                final int width = int.tryParse(_widthController.text) ?? 0;
                final int height = int.tryParse(_heightController.text) ?? 0;

                if (width >= 8 && width <= 20 && height >= 8 && height <= 20) {
                  ref
                      .read(gridDimensionsProvider.notifier)
                      .setDimensions(Size(width.toDouble(), height.toDouble()));
                  context.go('/grid');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter values between 8 and 20.'),
                    ),
                  );
                }
              },
              child: const Text('Continue'),
            ),
            const SizedBox(height: 16),
            savedCourses.when(
              data: (courses) {
                if (courses.isEmpty) {
                  return const SizedBox.shrink();
                }
                return ElevatedButton(
                  onPressed: () => context.go('/saved'),
                  child: const Text('Load Previously Saved Course'),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, st) => const SizedBox.shrink(),
            ),
            if (kIsWeb) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final course = await uploadCourseFromJson();
                  if (course != null) {
                    ref
                        .read(placedImagesProvider.notifier)
                        .loadState(course.images);
                    ref
                        .read(gridDimensionsProvider.notifier)
                        .setDimensions(course.dimensions);
                    ref.read(appTitleProvider.notifier).setTitle(course.title);
                    context.go('/grid');
                  }
                },
                child: const Text('Upload Course'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
