import 'package:flutter/material.dart';

class GroupUtils {
  static List<Color> getGroupTypeColors(String? groupType) {
    switch (groupType?.toLowerCase()) {
      case 'family':
        return [const Color(0xFF667EEA), const Color(0xFF764BA2)];
      case 'travel':
        return [const Color(0xFF11998E), const Color(0xFF38EF7D)];
      case 'business':
        return [const Color(0xFFFF6B6B), const Color(0xFFEE5A52)];
      case 'friends':
        return [const Color(0xFF4FACFE), const Color(0xFF00F2FE)];
      default:
        return [const Color(0xFF667EEA), const Color(0xFF764BA2)];
    }
  }

  static Map<String, dynamic> getGroupTypeInfo(String? groupType) {
    switch (groupType?.toLowerCase()) {
      case 'family':
        return {
          'icon': Icons.home_rounded,
          'label': 'عائلة',
          'color': const Color(0xFF667EEA),
        };
      case 'travel':
        return {
          'icon': Icons.flight_rounded,
          'label': 'سفر',
          'color': const Color(0xFF11998E),
        };
      case 'business':
        return {
          'icon': Icons.business_center_rounded,
          'label': 'عمل',
          'color': const Color(0xFFFF6B6B),
        };
      case 'friends':
        return {
          'icon': Icons.group_rounded,
          'label': 'أصدقاء',
          'color': const Color(0xFF4FACFE),
        };
      default:
        return {
          'icon': Icons.category_rounded,
          'label': 'أخرى',
          'color': const Color(0xFF667EEA),
        };
    }
  }
}
