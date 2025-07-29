import 'package:flutter/material.dart';
import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';

class GroupCardWidget extends StatefulWidget {
  final Groups group;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const GroupCardWidget({
    super.key,
    required this.group,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<GroupCardWidget> createState() => _GroupCardWidgetState();
}

class _GroupCardWidgetState extends State<GroupCardWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupColors = _getGroupTypeColors(widget.group.groupType);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) {
              _animationController.reverse();
              widget.onTap?.call();
            },
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              margin: const EdgeInsets.symmetric( vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    groupColors[0].withOpacity(0.03),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: groupColors[0].withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: groupColors[0].withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildHeader(groupColors),
                      const SizedBox(height: 16),
                      _buildContent(),
                      const SizedBox(height: 16),
                      _buildFooter(groupColors),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(List<Color> colors) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            _getGroupTypeIcon(widget.group.groupType),
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.group.name ?? 'مجموعة بدون اسم',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.group.description?.isNotEmpty == true) ...[
                const SizedBox(height: 4),
                Text(
                  widget.group.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        _buildOptionsMenu(colors[0]),
      ],
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        _buildStatusChip(),
        const SizedBox(width: 12),
        _buildTypeChip(),
        const Spacer(),
        _buildCurrencyChip(),
      ],
    );
  }

  Widget _buildFooter(List<Color> colors) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 6),
        Text(
          'تم الإنشاء: ${_formatDate(widget.group.createdAt)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
        const Spacer(),
        if (widget.group.createdBy != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colors[0].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'المنشئ',
              style: TextStyle(
                fontSize: 10,
                color: colors[0],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusChip() {
    final isActive = widget.group.isActive == 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isActive
              ? [const Color(0xFF10B981), const Color(0xFF059669)]
              : [const Color(0xFFF59E0B), const Color(0xFFD97706)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B))
                .withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? 'نشط' : 'غير نشط',
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

  Widget _buildTypeChip() {
    final typeInfo = _getGroupTypeInfo(widget.group.groupType);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: typeInfo['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: typeInfo['color'].withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            typeInfo['icon'],
            size: 14,
            color: typeInfo['color'],
          ),
          const SizedBox(width: 6),
          Text(
            typeInfo['label'],
            style: TextStyle(
              color: typeInfo['color'],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.monetization_on,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            widget.group.currency ?? 'SAR',
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

  Widget _buildOptionsMenu(Color primaryColor) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            widget.onEdit?.call();
            break;
          case 'delete':
            widget.onDelete?.call();
            break;
        }
      },
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.more_vert,
          size: 20,
          color: primaryColor,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, size: 20, color: primaryColor),
              const SizedBox(width: 12),
              const Text('تعديل'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete, size: 20, color: Colors.red),
              const SizedBox(width: 12),
              const Text('حذف'),
            ],
          ),
        ),
      ],
    );
  }

  // Helper methods
  List<Color> _getGroupTypeColors(String? groupType) {
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

  Map<String, dynamic> _getGroupTypeInfo(String? groupType) {
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

  IconData _getGroupTypeIcon(String? groupType) {
    return _getGroupTypeInfo(groupType)['icon'];
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'غير محدد';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'غير محدد';
    }
  }
}