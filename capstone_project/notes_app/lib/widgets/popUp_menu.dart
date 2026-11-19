
import 'package:flutter/material.dart';

class SimplePopupMenu extends StatelessWidget {
  final String item1;
  final String item2;
  final VoidCallback onItem1Tap;
  final VoidCallback onItem2Tap;
  final Widget? child;

  const SimplePopupMenu({
    super.key,
    required this.item1,
    required this.item2,
    required this.onItem1Tap,
    required this.onItem2Tap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        if (value == 1) onItem1Tap();
        if (value == 2) onItem2Tap();
      },
      child: child ?? const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(value: 1, child: Text(item1)),
        PopupMenuItem(value: 2, child: Text(item2)),
      ],
    );
  }
}
