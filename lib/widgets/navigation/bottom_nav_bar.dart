import 'package:flutter/material.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
          tooltip: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz_outlined),
          activeIcon: Icon(Icons.quiz),
          label: 'Quizzes',
          tooltip: 'Quizzes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
          tooltip: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
          tooltip: 'Settings',
        ),
      ],
    );
  }

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    String route;
    switch (index) {
      case 0:
        route = AppRoutes.home;
      case 1:
        route = AppRoutes.quiz;
      case 2:
        route = AppRoutes.profile;
      case 3:
        route = AppRoutes.settings;
      default:
        return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => route.settings.name == AppRoutes.home || route.isFirst,
    );
  }
}
