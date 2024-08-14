import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:flutter/widgets.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  const StatusWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Center(
      child: Text(title, style: theme.headline3),
    );
  }
}
