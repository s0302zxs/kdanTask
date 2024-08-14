import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/failure/failure.dart';
import 'utils.dart';

abstract class GuardStateNotifier<T> extends StateNotifier<T> {
  GuardStateNotifier(super._state);

  Future<bool> guard(
      Future<T> Function() future, {
        KDanConverter<Failure, bool?>? handleFailure,
      }) async {
    try {

      T result = await future();

      if (!mounted) return true;

      return true;
    } on Failure catch (e, stack) {

      if (!mounted) return false;

      if (handleFailure?.call(e) ?? false) {
        return false;
      } else {
        // state = AsyncValue.error(e, stack);
        return false;
      }
    } catch (e, stack) {

      if (!mounted) return false;

      var failure = Failure.exception(e, stack);

      if (handleFailure?.call(failure) ?? false) {
        return false;
      } else {
        // state = AsyncValue.error(failure, stack);
        return false;
      }
    }
  }

  void setState(T t) {
    if (!mounted) return;
  }

  void setError(Failure failure) {
    if (!mounted) return;
  }
}
