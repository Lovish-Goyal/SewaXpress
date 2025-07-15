import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sewaxpress/bottombar.dart';
import 'package:sewaxpress/features/auth/providers/auth_provider.dart';
import 'package:sewaxpress/features/auth/signup/signup_screen.dart';
import 'package:sewaxpress/features/profile/profile_screen.dart';
import 'package:sewaxpress/widgets/splash_screen.dart';
import '../features/auth/login/login_screen.dart';
import '../features/home/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // listen userProvider to refresh router when user changes
  ref.listen<AsyncValue<User?>>(userProvider, (previous, next) {
    // call notifyListeners on router to refresh redirects
    routerNotifier.notifyListeners();
  });

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: routerNotifier,

    // redirect: (context, state) {
    //   final userAsync = ref.read(userProvider);
    //   final isSplash = state.uri.toString() == '/splash';
    //   final isLogin =
    //       state.uri.toString() == '/login' || state.uri.toString() == '/signup';

    //   return userAsync.when(
    //     data: (user) {
    //       if (isSplash) return null;

    //       if (user == null && !isLogin) return '/login';

    //       if (user != null && isLogin) return '/home';

    //       return null;
    //     },
    //     loading: () => null,
    //     error: (_, __) => null,
    //   );
    // },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/', builder: (context, state) => const BottomBarScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/provider-login',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});

// A global ChangeNotifier to notify router refreshes
final routerNotifier = ChangeNotifier();
