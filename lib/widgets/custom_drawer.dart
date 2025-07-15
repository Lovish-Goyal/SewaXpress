import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers/auth_provider.dart';

class CustomEndDrawer extends ConsumerStatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  ConsumerState<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends ConsumerState<CustomEndDrawer> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'My Drawer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              context.go('/home');
            },
          ),

          // Settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.go('/settings'); // You should have this route defined
            },
          ),

          // Provider Login
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login as Provider'),
            onTap: () {
              Navigator.pop(context);
              context.push('/provider-login');
            },
          ),

          // Logout
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Logout'),
          //   onTap: () async {
          //     Navigator.pop(context); // Close drawer first
          //     final auth = ref.read(authServiceProvider);
          //     await auth.logout();
          //     if (context.mounted) {
          //       context.go('/');
          //     }
          //   },
          // ),
          userAsync.when(
            data: (user) {
              if (user == null) {
                print("null hai");
                return ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Login'),
                  onTap: () {
                    // Navigator.pop(context);
                    context.go('/login');
                  },
                );
              } else {
                print("null nhi hai");
                // ✅ Logged in user → Show Logout
                return ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    Navigator.pop(context); // Close drawer
                    final auth = ref.read(authServiceProvider);
                    await auth.logout();
                    if (context.mounted) {
                      context.go('/'); // Go to home
                    }
                  },
                );
              }
            },
            loading: () => const SizedBox.shrink(), // Or a loader
            error: (err, _) => ListTile(
              title: Text('Error: $err'),
              leading: const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
