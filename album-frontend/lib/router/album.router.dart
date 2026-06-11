
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/views/desktop/home_view_layouts/album_desktop.layout.dart';
import 'package:album_frontend/views/movile/home_view_layouts/album_movile.layout.dart';
import 'package:album_frontend/views/public_layouts/change_desk.layout.dart';
import 'package:album_frontend/views/public_layouts/inventory_desktop.layout.dart';
import 'package:album_frontend/views/public_layouts/sobres_desktop.layout.dart';
import 'package:album_frontend/views/home.view.dart';
import 'package:album_frontend/views/login.view.dart';
import 'package:album_frontend/views/movile/home_movile.layout.dart';
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
          return isDesktop ? HomeView(child: child,) : HomeMovile(child: child);
        },
          routes:[
            GoRoute(
                path: '/album',
                builder: (context , state) => isDesktop ? AlbumDesktop() : AlbumMovileLayout()
            ),
            GoRoute(
                path:'/inventory',
                builder: (context, state) => InventoryLayout()
            ),
            GoRoute(
                path: '/change',
                builder: (context, state) => ChangeDeskLayout()
            ),
            GoRoute(
                path: '/sobres',
                builder: (context, state) => SobresLayout()
            )
          ]
      )
    ]
);