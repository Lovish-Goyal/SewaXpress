import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/router.dart';
import 'utils/apiclient.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('68749b57002c1e8cc832')
    ..setSelfSigned();
  setPathUrlStrategy();
  runApp(ProviderScope(child: UrbanServicesApp()));
}

class UrbanServicesApp extends ConsumerWidget {
  const UrbanServicesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Urban Services',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1976D2),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
