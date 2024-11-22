import 'dart:io';

import 'package:civic_watch/cubits/auth/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'screens/account_screen.dart';
import 'screens/image_preview_page.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reports_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'section');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    final authState = context.read<AuthCubit>().state;

    if (authState is Authenticated) {
      return null; // Redirect to login if not authenticated
    }

    return '/login';
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(navigatorKey: _sectionNavigatorKey, routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const MapScreen(),
            routes: [
              GoRoute(
                path: '/image-preview',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                   final extra = state.extra as Map<String, dynamic>;
        final List<XFile> pictures = extra['pictures'];
        final File mapSnap = extra['mapSnap'];
                  return ImagePreviewPage(images: pictures, mapSnap: mapSnap);
                },
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/report',
            builder: (context, state) => const ReportsScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/proflie',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                    path: 'account',
                    name: 'account',
                    builder: (context, state) {
                      state.fullPath;
                      return const AccountScreen();
                    }),
              ]),
        ]),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
