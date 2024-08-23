import 'package:flutter/material.dart';
import 'package:titan/app/core/provider/navigator_provider.dart';

class AppHeaderButtonComponent extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isActive;
  final String navigateTo;
  const AppHeaderButtonComponent({
    required this.icon,
    required this.text,
    required this.isActive,
    required this.navigateTo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return FilledButton(
        onPressed: () => NavigatorProvider.navigate(navigateTo),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Text(text),
          ],
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: () => NavigatorProvider.navigate(navigateTo),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Text(text),
          ],
        ),
      );
    }
  }
}
