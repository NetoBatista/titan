import 'package:titan/app/core/model/execution/execution_response_model.dart';

abstract class IExecutionService {
  Future<List<ExecutionResponseModel>> get();
}
