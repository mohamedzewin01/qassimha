import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qassimha/features/CreateGroup/presentation/bloc/CreateGroup_cubit.dart';
import 'package:qassimha/features/CreateGroup/presentation/bloc/members/selected_members/selected_members_cubit.dart';

class ButtonCreateWidget extends StatelessWidget {
  const ButtonCreateWidget({
    super.key,
    required this.createGroup,
    required this.selectedMembersCubit,
  });

  final void Function()? createGroup;
  final SelectedMembersCubit selectedMembersCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupCubit, CreateGroupState>(
      builder: (context, createState) {
        return BlocBuilder<SelectedMembersCubit, SelectedMembersState>(
          bloc: selectedMembersCubit,
          builder: (context, membersState) {
            final isLoading = createState is CreateGroupsLoading;
            final hasMinimumMembers = membersState.selectedMembers.isNotEmpty;

            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1100),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Column(
                      children: [
                        // رسالة التحقق من صحة البيانات
                        if (hasMinimumMembers)
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'يجب إضافة عضو واحد على الأقل لإنشاء المجموعة',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // معلومات الأعضاء المختارين
                        if (hasMinimumMembers)
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline, color: Colors.green[600], size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'سيتم إضافة ${membersState.selectedMembers.length} عضو للمجموعة',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // زر الإنشاء
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: (isLoading || !hasMinimumMembers)
                                ? null
                                : createGroup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hasMinimumMembers
                                  ? const Color(0xFF667EEA)
                                  : Colors.grey[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: hasMinimumMembers ? 2 : 0,
                              shadowColor: hasMinimumMembers
                                  ? const Color(0xFF667EEA).withOpacity(0.3)
                                  : Colors.transparent,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: isLoading
                                  ? const Row(
                                key: ValueKey('loading'),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'جاري الإنشاء...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                                  : Text(
                                key: const ValueKey('create'),
                                hasMinimumMembers
                                    ? 'إنشاء المجموعة'
                                    : 'أضف عضو واحد على الأقل',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}