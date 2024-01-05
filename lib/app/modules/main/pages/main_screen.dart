import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_icons.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.navigationShell, {super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: ThemeData(splashFactory: NoSplash.splashFactory),
        child: SizedBox(
          height: 94,
          child: BottomNavigationBar(
            selectedFontSize: 14,
            backgroundColor: AppColors.background,
            elevation: 0,
            currentIndex: navigationShell.currentIndex,
            selectedLabelStyle: const TextStyle(fontSize: 0),
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            onTap: _onTap,
            items: _builItems(),
          ),
        ),
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  List<BottomNavigationBarItem> _builItems() {
    return [
      _buildBottomNavigationBarItem(
        icon: AppIcons.unactiveHome,
        activeIcon: AppIcons.activeHome,
      ),
      _buildBottomNavigationBarItem(
        icon: AppIcons.unactiveSearch,
        activeIcon: AppIcons.activeSearch,
      ),
      _buildBottomNavigationBarItem(
        icon: AppIcons.unactiveBookmark,
        activeIcon: AppIcons.activeBookmark,
      ),
      _buildBottomNavigationBarItem(
        icon: AppIcons.unactiveProfile,
        activeIcon: AppIcons.activeProfile,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {Widget? icon, Widget? activeIcon}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SizedBox(height: 24, width: 24, child: icon),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SizedBox(height: 24, width: 24, child: activeIcon),
      ),
      label: '',
    );
  }
}
