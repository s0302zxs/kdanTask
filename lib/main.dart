import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'provider/global_loading_provider.dart';
import 'routes/kdan_app_routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: KDanTaskApp(),
    ),
  );
}

class KDanTaskApp extends ConsumerWidget {
  const KDanTaskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(globalLoadingProvider, (previous, next) {
      if (previous == next) return;
      if (next == true) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
    });

    final route = ref.watch(routesProvider);

    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.light,
        routerConfig: route,
      ),
    );
  }
}
