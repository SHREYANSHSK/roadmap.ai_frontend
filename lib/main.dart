import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/providers/theme_notifier.dart';
import 'package:roadmap_ai/core/themes/themes.dart';
import 'package:roadmap_ai/router/router_config.dart';
import 'package:toastification/toastification.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen(callOptions: AnalyticsCallOptions(global: true));


  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ref
            .watch(themeNotifierProvider)
            .maybeWhen(
              data: (themeMode) => themeMode,
              orElse: () => ThemeMode.system,
            ),
      ),
    );
  }
}
