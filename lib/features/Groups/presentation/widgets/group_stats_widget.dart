import 'package:flutter/material.dart';
import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';

class GroupStatsWidget extends StatelessWidget {
  final List<Groups> groups;

  const GroupStatsWidget({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalGroups = groups.length;
    final activeGroups = groups.where((g) => g.isActive == 1).length;
    final groupTypes = _getGroupTypesCount();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'إجمالي المجموعات',
                  totalGroups.toString(),
                  Icons.groups_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  'المجموعات النشطة',
                  activeGroups.toString(),
                  Icons.check_circle,
                ),
              ),
            ],
          ),
          if (groupTypes.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupTypes.entries.map((entry) {
                return _buildTypeChip(entry.key, entry.value);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTypeChip(String type, int count) {
    final typeInfo = _getTypeInfo(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            typeInfo['icon'],
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '${typeInfo['label']} ($count)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, int> _getGroupTypesCount() {
    final Map<String, int> typesCount = {};
    for (final group in groups) {
      final type = group.groupType ?? 'other';
      typesCount[type] = (typesCount[type] ?? 0) + 1;
    }
    return typesCount;
  }

  Map<String, dynamic> _getTypeInfo(String type) {
    switch (type.toLowerCase()) {
      case 'family':
        return {'icon': Icons.home, 'label': 'عائلة'};
      case 'travel':
        return {'icon': Icons.flight, 'label': 'سفر'};
      case 'business':
        return {'icon': Icons.business, 'label': 'عمل'};
      case 'friends':
        return {'icon': Icons.group, 'label': 'أصدقاء'};
      default:
        return {'icon': Icons.category, 'label': 'أخرى'};
    }
  }
}