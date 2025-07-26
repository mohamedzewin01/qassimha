import 'package:flutter/material.dart';

class GroupFilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersApplied;
  final Map<String, dynamic> currentFilters;

  const GroupFilterBottomSheet({
    Key? key,
    required this.onFiltersApplied,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<GroupFilterBottomSheet> createState() => _GroupFilterBottomSheetState();
}

class _GroupFilterBottomSheetState extends State<GroupFilterBottomSheet> {
  late Map<String, dynamic> _filters;

  final List<Map<String, dynamic>> _groupTypes = [
    {'value': 'all', 'label': 'جميع الأنواع', 'icon': Icons.all_inclusive},
    {'value': 'family', 'label': 'عائلة', 'icon': Icons.home},
    {'value': 'travel', 'label': 'سفر', 'icon': Icons.flight},
    {'value': 'business', 'label': 'عمل', 'icon': Icons.business},
    {'value': 'friends', 'label': 'أصدقاء', 'icon': Icons.group},
  ];

  final List<String> _currencies = ['الكل', 'SAR', 'USD', 'EUR', 'AED'];
  final List<String> _statuses = ['الكل', 'نشط', 'غير نشط'];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'تصفية المجموعات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 24),

            // Group Type Filter
            _buildFilterSection(
              'نوع المجموعة',
              _buildGroupTypeFilter(),
            ),
            const SizedBox(height: 24),

            // Currency Filter
            _buildFilterSection(
              'العملة',
              _buildCurrencyFilter(),
            ),
            const SizedBox(height: 24),

            // Status Filter
            _buildFilterSection(
              'الحالة',
              _buildStatusFilter(),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF667EEA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'إعادة تعيين',
                      style: TextStyle(
                        color: Color(0xFF667EEA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667EEA),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'تطبيق',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildGroupTypeFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _groupTypes.map((type) {
        final isSelected = _filters['groupType'] == type['value'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _filters['groupType'] = type['value'];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF667EEA) : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? const Color(0xFF667EEA) : Colors.grey[300]!,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  type['icon'],
                  size: 18,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  type['label'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCurrencyFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _currencies.map((currency) {
        final isSelected = _filters['currency'] == currency;
        return GestureDetector(
          onTap: () {
            setState(() {
              _filters['currency'] = currency;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF10B981) : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? const Color(0xFF10B981) : Colors.grey[300]!,
              ),
            ),
            child: Text(
              currency,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusFilter() {
    return Row(
      children: _statuses.map((status) {
        final isSelected = _filters['status'] == status;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _filters['status'] = status;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF59E0B) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFFF59E0B) : Colors.grey[300]!,
                ),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _resetFilters() {
    setState(() {
      _filters = {
        'groupType': 'all',
        'currency': 'الكل',
        'status': 'الكل',
      };
    });
  }

  void _applyFilters() {
    widget.onFiltersApplied(_filters);
    Navigator.pop(context);
  }
}