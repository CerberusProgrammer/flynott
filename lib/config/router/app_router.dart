import 'package:flynott/components/components.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => const Home(),
  )
]);
