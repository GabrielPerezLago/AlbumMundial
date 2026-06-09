

import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/views/desktop/home_view_layouts/album_desktop.layout.dart';
import 'package:album_frontend/views/desktop/home_view_layouts/change_desk.layout.dart';
import 'package:album_frontend/views/desktop/home_view_layouts/inventory_desktop.layout.dart';
import 'package:album_frontend/views/home.view.dart';
import 'package:album_frontend/views/login.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/login",
    routes: [
      GoRoute(
          path: "/login",
          builder: (context, state) => LoginView()
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomeView(child: child,);
        },
          routes:[
            GoRoute(
                path: '/album',
                builder: (context , state) => AlbumDesktop()
            ),
            GoRoute(
                path:'/inventory',
                builder: (context, state) => InventoryDesktop()
            ),
            GoRoute(
                path: '/change',
                builder: (context, state) => ChangeDeskLayout()
            )
          ]
      )
    ]
);