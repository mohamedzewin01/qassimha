// lib/features/CreateGroup/presentation/bloc/selected_members/selected_members_state.dart
part of 'selected_members_cubit.dart';

@immutable
class SelectedMembersState {
  final List<SelectedMember> selectedMembers;

  const SelectedMembersState({
    this.selectedMembers = const [],
  });

  SelectedMembersState copyWith({
    List<SelectedMember>? selectedMembers,
  }) {
    return SelectedMembersState(
      selectedMembers: selectedMembers ?? this.selectedMembers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedMembersState &&
        other.selectedMembers.length == selectedMembers.length &&
        other.selectedMembers.every((member) => selectedMembers.contains(member));
  }

  @override
  int get hashCode => selectedMembers.hashCode;
}