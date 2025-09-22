import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/course_state.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/saved_courses_provider.dart';
import 'package:myapp/web_actions.dart';

class SavedCoursesScreen extends ConsumerWidget {
  const SavedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedCourses = ref.watch(savedCoursesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Courses')),
      body: savedCourses.when(
        data: (courses) => ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final courseName = courses[index];
            return ListTile(
              title: Text(courseName),
              onTap: () async {
                final router = GoRouter.of(context);
                final course = await ref
                    .read(savedCoursesProvider.notifier)
                    .loadCourse(courseName);
                if (course != null) {
                  ref
                      .read(placedImagesProvider.notifier)
                      .loadState(course.images);
                  ref
                      .read(gridDimensionsProvider.notifier)
                      .setDimensions(course.dimensions);
                  ref.read(appTitleProvider.notifier).setTitle(course.title);
                  router.go('/grid');
                }
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref
                      .read(savedCoursesProvider.notifier)
                      .deleteCourse(courseName);
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!kIsWeb)
            FloatingActionButton(
              heroTag: 'save',
              onPressed: () {
                _showSaveDialog(context, ref);
              },
              child: const Icon(Icons.save),
            ),
          if (kIsWeb) ...[
            FloatingActionButton(
              heroTag: 'download',
              onPressed: () {
                final course = CourseState(
                  images: ref.read(placedImagesProvider),
                  dimensions: ref.read(gridDimensionsProvider),
                  title: ref.read(appTitleProvider),
                );
                downloadCourseAsJson(ref.read(appTitleProvider), course);
              },
              child: const Icon(Icons.download),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: 'upload',
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
                  GoRouter.of(context).go('/grid');
                }
              },
              child: const Icon(Icons.upload),
            ),
          ],
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final images = ref.read(placedImagesProvider);
    final dimensions = ref.read(gridDimensionsProvider);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Course'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Course Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = titleController.text;
                if (title.isNotEmpty) {
                  final course = CourseState(
                    images: images,
                    dimensions: dimensions,
                    title: title,
                  );
                  ref
                      .read(savedCoursesProvider.notifier)
                      .saveCourse(title, course);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
