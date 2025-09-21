import 'package:go_router/go_router.dart';
import 'package:myapp/screens/input_screen.dart';
import 'package:myapp/screens/grid_screen.dart';
import 'package:myapp/screens/saved_courses_screen.dart';
import 'package:myapp/screens/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => InputScreen()),
    GoRoute(path: '/grid', builder: (context, state) => const GridScreen()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/saved',
      builder: (context, state) => const SavedCoursesScreen(),
    ),
  ],
);
