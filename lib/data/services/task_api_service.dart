import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdan_task/domain/entities/task.dart';
import 'package:retrofit/retrofit.dart';

import 'dio/task_dio.dart';

part 'task_api_service.g.dart';

final taskApiServiceProvider = Provider<TaskApiService>((ref) {
  final taskDio = ref.watch(taskDioProvider);
  return TaskApiService(taskDio);
});

@RestApi()
abstract class TaskApiService {
  factory TaskApiService(Dio dio) = _TaskApiService;

  // TODO: define task api
  @POST('')
  Future<HttpResponse<Task>> getAllTasks();

}
