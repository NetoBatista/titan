import 'package:titan/app/core/model/event/event_response_model.dart';
import 'package:titan/app/core/model/execution/execution_response_model.dart';
import 'package:titan/app/core/provider/date_provider.dart';
import 'package:titan/app/core/provider/dependency_provider.dart';
import 'package:titan/app/module/home/model/home_execution_model.dart';

class HomeExecutionAdapter {
  static HomeExecutionModel toHomeExecutionModel(
    ExecutionResponseModel execution,
    EventResponseModel event,
  ) {
    DateProvider dateProvider = DependencyProvider.get();
    var dateTime = DateTime.parse(execution.createdAt).toLocal();
    return HomeExecutionModel(
      id: execution.id,
      name: event.name,
      url: event.url,
      status: execution.step,
      date: dateProvider.formatDateTimeFromJson(dateTime.toIso8601String()),
    );
  }
}
