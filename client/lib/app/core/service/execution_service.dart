import 'package:titan/app/core/adapter/execution/execution_response_adapter.dart';
import 'package:titan/app/core/interface/iexecution_service.dart';
import 'package:titan/app/core/interface/irequest_service.dart';
import 'package:titan/app/core/model/execution/execution_response_model.dart';

class ExecutionService implements IExecutionService {
  final IRequestService _requestService;
  ExecutionService(this._requestService);

  @override
  Future<List<ExecutionResponseModel>> get() async {
    var response = await _requestService.get('Execution');
    if (response.statusCode != 200) {
      return [];
    }
    return ExecutionResponseAdapter.fromJsonList(response.body);
  }
}
