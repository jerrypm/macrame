import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/authentication/pages/login_screen.dart';
import '../../modules/authentication/pages/register_screen.dart';
import '../../modules/bookmark/pages/bookmark_screen.dart';
import '../../modules/cart/pages/cart_screen.dart';
import '../../modules/details/pages/details_screen.dart';
import '../../modules/home/pages/home_screen.dart';
import '../../modules/home/pages/notifications_screen.dart';
import '../../modules/main/pages/main_screen.dart';
import '../../modules/profile/pages/detail_orders_screen.dart';
import '../../modules/profile/pages/my_orders_screen.dart';
import '../../modules/profile/pages/my_reviews_screen.dart';
import '../../modules/profile/pages/profile_screen.dart';
import '../../modules/profile/pages/settings_screen.dart';
import '../../modules/profile/pages/web_views_screen.dart';
import '../../modules/search/pages/search_screen.dart';
import '../../modules/splash/pages/splash_screen.dart';
import 'app_routes.dart';

mixin class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.splash.path,
      routes: [
        GoRoute(
          name: AppRoutes.splash.name,
          path: AppRoutes.splash.path,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.register.name,
          path: AppRoutes.register.path,
          builder: (context, state) {
            return const RegisterScreen();
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScreen(navigationShell);
          },
          branches: _buildBranches(),
        )
      ],
    );
  }

  static List<StatefulShellBranch> _buildBranches() {
    return [
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.notification.name,
                path: AppRoutes.notification.name,
                builder: (context, state) {
                  return const NotificationScreen();
                },
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.details.name,
                path: "${AppRoutes.details.name}/:id_item",
                builder: (context, state) {
                  var parameters = state.pathParameters['id_item'];
                  var idItems = double.parse(parameters.toString());

                  return DetailsScreen(idItem: idItems.toInt());
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            name: AppRoutes.search.name,
            path: AppRoutes.search.path,
            builder: (context, state) {
              return const SearchScreen();
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            name: AppRoutes.bookmark.name,
            path: AppRoutes.bookmark.path,
            builder: (context, state) {
              return const BookmarkScreen();
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.cart.name,
                path: AppRoutes.cart.name,
                builder: (context, state) {
                  return const CartScreen();
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            name: AppRoutes.profile.name,
            path: AppRoutes.profile.path,
            builder: (context, state) {
              return const ProfileScreen();
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.myOrders.name,
                path: AppRoutes.myOrders.name,
                builder: (context, state) {
                  return const MyOrdersScreen();
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoutes.orderDetails.name,
                    path: "${AppRoutes.orderDetails.name}/:order_id",
                    builder: (context, state) {
                      var parameters = state.pathParameters['order_id'];
                      var orderId = double.parse(parameters.toString());
                      return DetailsOrdersScreen(orderId: orderId.toInt());
                    },
                  ),
                ],
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.myReviews.name,
                path: AppRoutes.myReviews.name,
                builder: (context, state) {
                  return const MyReviewsScreen();
                },
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.settings.name,
                path: AppRoutes.settings.name,
                builder: (context, state) {
                  return const SettingsScreen();
                },
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: AppRoutes.webViews.name,
                path: "${AppRoutes.webViews.name}/:url",
                builder: (context, state) {
                  var url = state.pathParameters['url'];
                  var extra = state.extra as Map<String, dynamic>;
                  var title = extra['title'];
                  return WebViews(url: url, title: title);
                },
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
