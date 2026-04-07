import 'package:finflow_app/core/widgets/ff_bottom_nav.dart';
import 'package:finflow_app/features/accounts/presentation/screens/accounts_screen.dart';
import 'package:finflow_app/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:finflow_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:finflow_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:finflow_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:finflow_app/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const _paths = [
    '/dashboard',
    '/transactions',
    '/calendar',
    '/settings',
  ];

  static int _indexFromLocation(String location) {
    return _paths.indexOf("/${location.split('/')[1]}");
  }

  static final router = GoRouter(
    initialLocation: '/settings/categories',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: FFBottomNav(
              currentIndex: _indexFromLocation(state.uri.path),
              onDestinationSelected: (idx) => context.go(_paths[idx]),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/transactions',
            builder: (context, state) => const TransactionsScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'categories',
                builder: (context, state) => const CategoriesScreen(),
              ),
              GoRoute(
                path: 'accounts',
                builder: (context, state) => const AccountsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
