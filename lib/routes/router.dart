import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sewaxpress/bottombar.dart';
import 'package:sewaxpress/features/about_us/about_us.dart';
import 'package:sewaxpress/features/auth/providers/auth_provider.dart';
import 'package:sewaxpress/features/auth/signup/signup_screen.dart';
import 'package:sewaxpress/features/contact_us/contact_us.dart';
import 'package:sewaxpress/features/notifications/notifications_screen.dart';
import 'package:sewaxpress/features/privacy_policy/privacy_policy_screen.dart';
import 'package:sewaxpress/features/profile/profile_screen.dart';
import 'package:sewaxpress/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:sewaxpress/widgets/splash_screen.dart';
import '../features/auth/login/login_screen.dart';

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
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutUsScreen(),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/termsandconditions',
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
      GoRoute(
        path: '/privacyPolicy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/providerLogin',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/providerProfile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});

// A global ChangeNotifier to notify router refreshes
final routerNotifier = ChangeNotifier();
