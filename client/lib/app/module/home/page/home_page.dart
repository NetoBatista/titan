import 'package:flutter/material.dart';
import 'package:titan/app/core/extension/context_extension.dart';
import 'package:titan/app/core/provider/dependency_provider.dart';
import 'package:titan/app/module/home/component/home_table_component.dart';
import 'package:titan/app/module/home/controller/home_controller.dart';
import 'package:titan/app/module/home/state/home_state.dart';
import 'package:titan/app/shared/component/app_header/app_header_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = DependencyProvider.get<HomeController>();
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watchContext();
    var state = _controller.value;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AppHeaderComponent(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: state is HomeLoadingate,
                  child: const LinearProgressIndicator(),
                ),
                if (state is HomeErrorState)
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(state.error),
                    ],
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 180,
                  child: SingleChildScrollView(
                    child: HomeTableComponent(controller: _controller),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
