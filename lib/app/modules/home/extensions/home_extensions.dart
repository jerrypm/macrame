import 'package:flutter/material.dart';

import '../../../config/themes/app_icons.dart';

enum HomeCategory {
  wall,
  pot,
  bag,
  clothing,
  decor,
  jawerly,
}

extension HomeCategoryExtension on HomeCategory {
  String get name {
    switch (this) {
      case HomeCategory.wall:
        return 'Wall';
      case HomeCategory.pot:
        return 'Pot';
      case HomeCategory.bag:
        return 'Bag';
      case HomeCategory.clothing:
        return 'Cloting';
      case HomeCategory.decor:
        return 'Decor';
      case HomeCategory.jawerly:
        return 'Jawerly';
      default:
        return '';
    }
  }

  String get catalogType {
    switch (this) {
      case HomeCategory.wall:
        return 'wall';
      case HomeCategory.pot:
        return 'bags';
      case HomeCategory.bag:
        return 'bag';
      case HomeCategory.clothing:
        return 'wall';
      case HomeCategory.decor:
        return 'wall';
      case HomeCategory.jawerly:
        return 'wall';
      default:
        return 'wall';
    }
  }

  Widget get iconActive {
    switch (this) {
      case HomeCategory.wall:
        return AppIcons.activeWallArt;
      case HomeCategory.pot:
        return AppIcons.activePlant;
      case HomeCategory.bag:
        return AppIcons.activeBag;
      case HomeCategory.clothing:
        return AppIcons.activeClothing;
      case HomeCategory.decor:
        return AppIcons.activeArt;
      case HomeCategory.jawerly:
        return AppIcons.activeJawerly;
      default:
        return const SizedBox.shrink();
    }
  }

  Widget get iconUnactive {
    switch (this) {
      case HomeCategory.wall:
        return AppIcons.unactiveWallArt;
      case HomeCategory.pot:
        return AppIcons.unactivePlant;
      case HomeCategory.bag:
        return AppIcons.unactiveBag;
      case HomeCategory.clothing:
        return AppIcons.unactiveClothing;
      case HomeCategory.decor:
        return AppIcons.unactiveArt;
      case HomeCategory.jawerly:
        return AppIcons.unactiveJawerly;
      default:
        return const SizedBox.shrink();
    }
  }
}
