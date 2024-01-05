enum AppRoutes {
  splash,
  login,
  register,
  forgotPassword,
  details,
  home,
  notification,
  search,
  bookmark,
  cart,
  profile,
  myOrders,
  orderDetails,
  myReviews,
  settings,
  //
  webViews,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return '/splash';
      case AppRoutes.login:
        return '/login';
      case AppRoutes.register:
        return '/register';
      case AppRoutes.forgotPassword:
        return '/forgot-password';
      case AppRoutes.details:
        return '/detail';
      case AppRoutes.home:
        return '/home';
      case AppRoutes.search:
        return '/search';
      case AppRoutes.bookmark:
        return '/bookmark';
      case AppRoutes.cart:
        return '/cart';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.myOrders:
        return '/my-orders';
      case AppRoutes.orderDetails:
        return '/order-detail';
      case AppRoutes.myReviews:
        return '/my-reviews';
      case AppRoutes.settings:
        return '/settings';
      case AppRoutes.webViews:
        return '/web-views';
      default:
        return '/login';
    }
  }
}
