import 'package:flutter_modular/flutter_modular.dart';

class NavigatorProvider {
  static void navigate(String path, {dynamic arguments}) {
    Modular.to.navigate(path, arguments: arguments);
  }

  static void pop() {
    Modular.to.pop();
  }

  static String path() {
    return Modular.to.path;
  }
}
