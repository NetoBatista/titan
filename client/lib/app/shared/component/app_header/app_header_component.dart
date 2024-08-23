import 'package:flutter/material.dart';
import 'package:titan/app/core/extension/string_extension.dart';
import 'package:titan/app/core/provider/navigator_provider.dart';
import 'package:titan/app/shared/component/app_header/app_header_button_component.dart';

class AppHeaderComponent extends StatelessWidget {
  const AppHeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                const Icon(Icons.window, size: 36),
                const SizedBox(width: 8),
                const Text('Titan', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                const VerticalDivider(color: Colors.grey, thickness: 1),
                const SizedBox(width: 8),
                AppHeaderButtonComponent(
                  icon: Icons.home_outlined,
                  isActive: NavigatorProvider.path() == "/",
                  text: 'header.button.home'.translate(),
                  navigateTo: '/',
                ),
                const SizedBox(width: 16),
                AppHeaderButtonComponent(
                  icon: Icons.show_chart_outlined,
                  isActive: NavigatorProvider.path() == "/event/",
                  text: 'header.button.events'.translate(),
                  navigateTo: '/event/',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
