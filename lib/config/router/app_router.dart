import 'package:flynott/components/components.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: Home.appRouterName,
    builder: (context, state) => const Home(),
  )
]);
