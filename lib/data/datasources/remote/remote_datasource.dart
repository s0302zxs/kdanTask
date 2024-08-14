import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/task_api_service.dart';

final remoteDatasourceProvider = Provider<RemoteDatasource>((ref) {
  final taskApiService = ref.watch(taskApiServiceProvider);
  return RemoteDatasource(taskApiService);
});

class RemoteDatasource {
  final TaskApiService taskApiService;

  RemoteDatasource(this.taskApiService);


  //TODO : remote future function

}
