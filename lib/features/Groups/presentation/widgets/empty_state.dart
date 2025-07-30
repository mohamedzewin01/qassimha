import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.navigateToCreateGroup});
final VoidCallback navigateToCreateGroup;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.groups_rounded,
              size: 64,
              color: Color(0xFF667EEA),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'لا توجد مجموعات حتى الآن',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ بإنشاء مجموعتك الأولى',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => navigateToCreateGroup,
            icon: const Icon(Icons.add),
            label: const Text('إنشاء مجموعة جديدة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
