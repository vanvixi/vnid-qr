import 'package:flutter/material.dart';

class ScaffoldResponsive extends StatelessWidget {
  const ScaffoldResponsive({
    super.key,
    this.appBar,
    required this.mobileBuilder,
    required this.tabletBuilder,
  });

  final PreferredSizeWidget? appBar;
  final WidgetBuilder mobileBuilder;
  final WidgetBuilder tabletBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Align(
        alignment: .topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return switch (constraints.maxWidth) {
                < 720 => mobileBuilder(context),
                _ => tabletBuilder(context),
              };
            },
          ),
        ),
      ),
    );
  }
}
