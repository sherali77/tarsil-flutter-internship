import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).disabledColor;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note, size: 80, color: color),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: color, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}