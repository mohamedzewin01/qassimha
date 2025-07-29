import 'package:flutter/material.dart';

class GroupsSearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback? onFilterTap;
  final bool hasActiveFilters;

  const GroupsSearchWidget({
    Key? key,
    required this.onSearchChanged,
    this.onFilterTap,
    this.hasActiveFilters = false,
  }) : super(key: key);

  @override
  State<GroupsSearchWidget> createState() => _GroupsSearchWidgetState();
}

class _GroupsSearchWidgetState extends State<GroupsSearchWidget>
    with TickerProviderStateMixin {

  late AnimationController _searchController;
  late AnimationController _filterController;
  late AnimationController _pulseController;

  late Animation<double> _searchScaleAnimation;
  late Animation<double> _filterScaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _filterColorAnimation;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSearchFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    _searchController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _filterController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _searchScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _searchController,
      curve: Curves.easeInOut,
    ));

    _filterScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _filterController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _filterColorAnimation = ColorTween(
      begin: const Color(0xFF667EEA),
      end: const Color(0xFFEF4444),
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _focusNode.addListener(_onFocusChanged);
    _textController.addListener(_onTextChanged);

    // Start pulse animation if filters are active
    if (widget.hasActiveFilters) {
      _startPulseAnimation();
    }
  }

  void _startPulseAnimation() {
    _pulseController.repeat(reverse: true);
  }

  void _stopPulseAnimation() {
    _pulseController.stop();
    _pulseController.reset();
  }

  @override
  void didUpdateWidget(GroupsSearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasActiveFilters != oldWidget.hasActiveFilters) {
      if (widget.hasActiveFilters) {
        _startPulseAnimation();
      } else {
        _stopPulseAnimation();
      }
    }
  }

  void _onFocusChanged() {
    setState(() {
      _isSearchFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    final hasText = _textController.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
    widget.onSearchChanged(_textController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterController.dispose();
    _pulseController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _textController.removeListener(_onTextChanged);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: AnimatedBuilder(
              animation: _searchScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _searchScaleAnimation.value,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      gradient: _isSearchFocused
                          ? const LinearGradient(
                        colors: [Colors.white, Color(0xFFF8FAFC)],
                      )
                          : null,
                      color: _isSearchFocused ? null : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: _isSearchFocused
                              ? const Color(0xFF667EEA).withOpacity(0.2)
                              : Colors.black.withOpacity(0.08),
                          blurRadius: _isSearchFocused ? 25 : 20,
                          offset: Offset(0, _isSearchFocused ? 8 : 4),
                          spreadRadius: _isSearchFocused ? 0 : -2,
                        ),
                        if (_isSearchFocused)
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.1),
                            blurRadius: 40,
                            offset: const Offset(0, 0),
                            spreadRadius: 4,
                          ),
                      ],
                      border: Border.all(
                        color: _isSearchFocused
                            ? const Color(0xFF667EEA).withOpacity(0.3)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'البحث في المجموعات...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: _isSearchFocused
                                ? const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            )
                                : null,
                            color: _isSearchFocused ? null : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.search_rounded,
                            color: _isSearchFocused ? Colors.white : Colors.grey[500],
                            size: 20,
                          ),
                        ),
                        suffixIcon: _hasText
                            ? AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: IconButton(
                            key: const ValueKey('clear_button'),
                            onPressed: () {
                              _textController.clear();
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                            ),
                          ),
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF374151),
                      ),
                      onTapOutside: (_) => _focusNode.unfocus(),
                    ),
                  ),
                );
              },
            ),
          ),

          // Filter button
          if (widget.onFilterTap != null) ...[
            const SizedBox(width: 12),
            AnimatedBuilder(
              animation: Listenable.merge([
                _filterScaleAnimation,
                _pulseAnimation,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _filterScaleAnimation.value *
                      (widget.hasActiveFilters ? _pulseAnimation.value : 1.0),
                  child: GestureDetector(
                    onTapDown: (_) => _filterController.forward(),
                    onTapUp: (_) {
                      _filterController.reverse();
                      widget.onFilterTap?.call();
                    },
                    onTapCancel: () => _filterController.reverse(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: widget.hasActiveFilters
                            ? LinearGradient(
                          colors: [
                            _filterColorAnimation.value ?? const Color(0xFF667EEA),
                            const Color(0xFF764BA2),
                          ],
                        )
                            : const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: (widget.hasActiveFilters
                                ? _filterColorAnimation.value ?? const Color(0xFF667EEA)
                                : const Color(0xFF667EEA)).withOpacity(0.4),
                            blurRadius: widget.hasActiveFilters ? 20 : 12,
                            offset: Offset(0, widget.hasActiveFilters ? 8 : 6),
                          ),
                          if (widget.hasActiveFilters)
                            BoxShadow(
                              color: (_filterColorAnimation.value ?? const Color(0xFF667EEA))
                                  .withOpacity(0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 0),
                              spreadRadius: 4,
                            ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          if (widget.hasActiveFilters)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}