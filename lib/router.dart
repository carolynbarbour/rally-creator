import 'package:go_router/go_router.dart';
import 'package:myapp/screens/input_screen.dart';
import 'package:myapp/screens/grid_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => InputScreen(),
    ),
    GoRoute(
      path: '/grid',
      builder: (context, state) => const GridScreen(),
    ),
  ],
);
