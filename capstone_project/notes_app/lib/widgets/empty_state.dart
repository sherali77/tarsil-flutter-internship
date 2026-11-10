import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message; 

  const EmptyState({
    super.key,
    required this.message, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 12), 
          Text(
            message, 
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}