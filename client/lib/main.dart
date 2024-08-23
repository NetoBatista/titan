import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:titan/main_module.dart';
import 'package:titan/main_widget.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    ModularApp(
      module: MainModule(),
      child: const MainWidget(),
    ),
  );
}
