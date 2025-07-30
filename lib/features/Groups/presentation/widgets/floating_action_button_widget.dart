import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, required this.navigateToCreateGroup});
  final VoidCallback navigateToCreateGroup;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => navigateToCreateGroup(),
      backgroundColor: const Color(0xFF667EEA),
      icon: const Icon(Icons.add),
      label: const Text('إضافة مجموعة'),
    );;
  }
}
