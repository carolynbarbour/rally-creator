import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/course_state.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/saved_courses_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSaveDialog(context, ref);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  void _showSaveDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: ref.read(appTitleProvider));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Course'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter course name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final name = controller.text;
              if (name.isNotEmpty) {
                final course = CourseState(
                  images: ref.read(placedImagesProvider),
                  dimensions: ref.read(gridDimensionsProvider),
                  title: ref.read(appTitleProvider),
                );
                await ref
                    .read(savedCoursesProvider.notifier)
                    .saveCourse(name, course);
                navigator.pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
