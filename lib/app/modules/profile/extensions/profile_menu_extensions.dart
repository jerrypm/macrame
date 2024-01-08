enum ProfileMenu {
  orders,
  reviews,
  settings,
}

extension ProfileMenuExtension on ProfileMenu {
  String get name {
    switch (this) {
      case ProfileMenu.orders:
        return 'My orders';
      case ProfileMenu.reviews:
        return 'My reviews';
      case ProfileMenu.settings:
        return 'Settings';
      default:
        return '';
    }
  }

  String subtitle(
      {String orders = 'Status Orders',
      String reviews = 'Review for 5 items'}) {
    switch (this) {
      case ProfileMenu.orders:
        return orders;
      case ProfileMenu.reviews:
        return 'My reviews';
      case ProfileMenu.settings:
        return 'Notification, Password, FAQ, Contact';
      default:
        return '';
    }
  }
}
