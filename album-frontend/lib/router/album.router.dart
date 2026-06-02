

import 'package:album_frontend/views/login.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/login",
    routes: [
      GoRoute(
          path: "/login",
          builder: (context, state) => LoginView()
      )
    ]
);