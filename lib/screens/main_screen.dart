import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../helpers/env_helper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget showBanner(bool show, Widget child) {
    if (show) {
      return Banner(
        location: BannerLocation.topStart,
        message: 'Dev',
        color: Colors.green.withOpacity(0.6),
        textStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
        child: child,
      );
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return showBanner(
      kDebugMode && Env.type == 'dev',
      Scaffold(
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.4),
              currentIndex: navigationShell.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.map),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.fileText),
                  label: 'Reports',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.user),
                  label: 'Profile',
                ),
              ],
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
