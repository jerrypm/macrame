import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_page_transitions_theme.dart';

mixin class AppTheme {
  static ThemeData defaults() {
    return ThemeData(
      fontFamily: 'Raleway',
      scaffoldBackgroundColor: AppColors.background,
      pageTransitionsTheme: getPageTransitionsTheme,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.background,
          surfaceTintColor: AppColors.background,
          elevation: 0,
          toolbarHeight: 50),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.arsenic,
        ),
      ),
      tabBarTheme: const TabBarTheme(),
      cardTheme: const CardTheme(),
      chipTheme: const ChipThemeData(),
      iconTheme: const IconThemeData(),
      menuTheme: const MenuThemeData(),
      badgeTheme: const BadgeThemeData(),
      radioTheme: const RadioThemeData(),
      textTheme: const TextTheme(),
      bannerTheme: const MaterialBannerThemeData(),
      buttonTheme: const ButtonThemeData(),
      dialogTheme: const DialogTheme(),
      drawerTheme: const DrawerThemeData(),
      sliderTheme: const SliderThemeData(),
      switchTheme: const SwitchThemeData(),
      bottomSheetTheme: const BottomSheetThemeData(),
      dividerTheme: const DividerThemeData(),
      menuBarTheme: const MenuBarThemeData(),
      checkboxTheme: const CheckboxThemeData(),
      listTileTheme: const ListTileThemeData(),
      snackBarTheme: const SnackBarThemeData(),
      tooltipTheme: const TooltipThemeData(),
      buttonBarTheme: const ButtonBarThemeData(),
      popupMenuTheme: const PopupMenuThemeData(),
      iconButtonTheme: const IconButtonThemeData(),
      actionIconTheme: const ActionIconThemeData(),
      scrollbarTheme: const ScrollbarThemeData(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      dataTableTheme: const DataTableThemeData(),
      textButtonTheme: const TextButtonThemeData(),
      dropdownMenuTheme: const DropdownMenuThemeData(),
    );
  }
}
