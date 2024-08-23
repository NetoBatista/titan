import 'package:titan/app/core/extension/string_extension.dart';

class ExecutionStepConstant {
  static const String created = "CREATED";
  static const String inProgress = "IN_PROGRESS";
  static const String fail = "FAIL";
  static const String success = "SUCCESS";

  static String translate(String value) {
    return "execution-step.${value.toLowerCase()}".translate();
  }
}
