// lib/features/CreateGroup/presentation/widgets/enhanced_add_members_widget.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qassimha/core/di/di.dart';
import 'package:qassimha/features/CreateGroup/data/models/response/get_members_model.dart';
import 'package:qassimha/features/CreateGroup/data/models/selected_member.dart';
import 'package:qassimha/features/CreateGroup/presentation/bloc/members/members_cubit.dart';
import 'package:qassimha/features/CreateGroup/presentation/bloc/members/selected_members/selected_members_cubit.dart';

class AddMembersWidget extends StatefulWidget {
  final SelectedMembersCubit selectedMembersCubit; // استقبل الـ cubit من الخارج

  const AddMembersWidget({
    super.key,
    required this.selectedMembersCubit, // اجعله مطلوب
  });

  @override
  State<AddMembersWidget> createState() => _AddMembersWidgetState();
}

class _AddMembersWidgetState extends State<AddMembersWidget> {
  late MembersCubit membersCubit;
  late TextEditingController searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    membersCubit = getIt.get<MembersCubit>();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 500), () {
      membersCubit.getMembers(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: membersCubit),
        BlocProvider.value(value: widget.selectedMembersCubit), // استخدم الـ cubit المُمرر
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          const Text(
            'إضافة أعضاء',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'ابحث عن الأعضاء بالإيميل أو رقم الهاتف (الحد الأدنى: عضو واحد)',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 16),

          // صندوق البحث
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'ابحث بالإيميل أو رقم الهاتف...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF718096)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                hintStyle: TextStyle(color: Color(0xFF718096)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // الأعضاء المختارين
          BlocBuilder<SelectedMembersCubit, SelectedMembersState>(
            builder: (context, selectedState) {
              print('Selected Members Count: ${selectedState.selectedMembers.length}'); // للتتبع

              if (selectedState.selectedMembers.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'الأعضاء المختارين',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF667EEA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${selectedState.selectedMembers.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: selectedState.selectedMembers.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final member = selectedState.selectedMembers[index];
                          return _buildSelectedMemberItem(member);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // نتائج البحث
          BlocBuilder<MembersCubit, MembersState>(
            builder: (context, state) {
              if (state is GetMembersLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is GetMembersSuccess) {
                final results = state.getMembersEntity.results ?? [];
                if (results.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: const Center(
                      child: Text(
                        'لم يتم العثور على نتائج',
                        style: TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: results.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return _buildSearchResultItem(result);
                    },
                  ),
                );
              }

              if (state is GetMembersFailure) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: const Center(
                    child: Text(
                      'حدث خطأ أثناء البحث',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

          // رسالة التحقق من الحد الأدنى
          BlocBuilder<SelectedMembersCubit, SelectedMembersState>(
            builder: (context, state) {
              if (state.selectedMembers.isEmpty) {
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'يجب إضافة عضو واحد على الأقل',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(Results result) {
    return BlocBuilder<SelectedMembersCubit, SelectedMembersState>(
      builder: (context, selectedState) {
        final isSelected = widget.selectedMembersCubit.isMemberSelected(result.id ?? '');

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF667EEA),
            backgroundImage: result.avatarUrl != null
                ? NetworkImage(result.avatarUrl!)
                : null,
            child: result.avatarUrl == null
                ? Text(
              (result.displayName ?? '').isNotEmpty
                  ? (result.displayName![0].toUpperCase())
                  : '?',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
                : null,
          ),
          title: Text(
            result.displayName ?? 'غير محدد',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (result.email?.isNotEmpty == true)
                Text(result.email!, style: const TextStyle(fontSize: 13)),
              if (result.phone?.isNotEmpty == true)
                Text(result.phone!, style: const TextStyle(fontSize: 13)),
            ],
          ),
          trailing: IconButton(
            onPressed: isSelected
                ? () {
              print('Removing member: ${result.id}'); // للتتبع
              widget.selectedMembersCubit.removeMember(result.id ?? '');
            }
                : () {
              print('Adding member: ${result.id}'); // للتتبع
              final member = SelectedMember.fromResults(result);
              widget.selectedMembersCubit.addMember(member);
            },
            icon: Icon(
              isSelected ? Icons.remove_circle : Icons.add_circle,
              color: isSelected ? Colors.red : const Color(0xFF667EEA),
            ),
          ),
          onTap: () {
            if (!isSelected) {
              print('Tapping to add member: ${result.id}'); // للتتبع
              final member = SelectedMember.fromResults(result);
              widget.selectedMembersCubit.addMember(member);
            }
          },
        );
      },
    );
  }

  Widget _buildSelectedMemberItem(SelectedMember member) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF667EEA).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF667EEA).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF667EEA),
            backgroundImage: member.avatarUrl != null
                ? NetworkImage(member.avatarUrl!)
                : null,
            child: member.avatarUrl == null
                ? Text(
              member.displayName.isNotEmpty
                  ? member.displayName[0].toUpperCase()
                  : '?',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  member.email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              print('Removing member from selected: ${member.id}'); // للتتبع
              widget.selectedMembersCubit.removeMember(member.id);
            },
            icon: const Icon(Icons.close, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }
}