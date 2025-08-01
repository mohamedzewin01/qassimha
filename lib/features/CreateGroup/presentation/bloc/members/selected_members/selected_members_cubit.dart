// lib/features/CreateGroup/presentation/bloc/selected_members/selected_members_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:qassimha/features/CreateGroup/data/models/selected_member.dart';
import '../../../../data/models/request/create_group_request.dart';


part 'selected_members_state.dart';

@injectable
class SelectedMembersCubit extends Cubit<SelectedMembersState> {
  SelectedMembersCubit() : super(const SelectedMembersState());

  // إضافة عضو جديد
  void addMember(SelectedMember member) {
    if (!state.selectedMembers.contains(member)) {
      final updatedMembers = List<SelectedMember>.from(state.selectedMembers)
        ..add(member);
      emit(state.copyWith(selectedMembers: updatedMembers));
    }
  }

  // إزالة عضو
  void removeMember(String memberId) {
    final updatedMembers = state.selectedMembers
        .where((member) => member.id != memberId)
        .toList();
    emit(state.copyWith(selectedMembers: updatedMembers));
  }

  // تحديث دور العضو
  void updateMemberRole(String memberId, String newRole) {
    final updatedMembers = state.selectedMembers.map((member) {
      if (member.id == memberId) {
        return member.copyWith(role: newRole);
      }
      return member;
    }).toList();
    emit(state.copyWith(selectedMembers: updatedMembers));
  }

  // مسح جميع الأعضاء
  void clearMembers() {
    emit(const SelectedMembersState());
  }

  // التحقق من الحد الأدنى للأعضاء
  bool get hasMinimumMembers => state.selectedMembers.isNotEmpty;

  // الحصول على قائمة الأعضاء للإرسال في API
  List<Members> getMembersForRequest() {
    return state.selectedMembers
        .map((member) => member.toMembersRequest())
        .toList();
  }

  // التحقق من وجود عضو
  bool isMemberSelected(String memberId) {
    return state.selectedMembers.any((member) => member.id == memberId);
  }
}