import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalLoadingNotifier extends StateNotifier<bool> {
  GlobalLoadingNotifier({required bool? loading}) : super(false);

  void showLoading() {
    state = true;
  }

  void hideLoading() {
    state = false;
  }
}

final globalLoadingProvider = StateNotifierProvider<GlobalLoadingNotifier, bool>(
      (ref) => GlobalLoadingNotifier(loading: false),
);
