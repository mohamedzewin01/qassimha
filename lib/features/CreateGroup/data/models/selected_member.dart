// lib/features/CreateGroup/data/models/selected_member.dart
import 'package:qassimha/features/CreateGroup/data/models/request/create_group_request.dart';
import 'package:qassimha/features/CreateGroup/data/models/response/get_members_model.dart';

class SelectedMember {
  final String id;
  final String email;
  final String displayName;
  final String? phone;
  final String? avatarUrl;
  final String role; // 'admin' or 'member'

  SelectedMember({
    required this.id,
    required this.email,
    required this.displayName,
    this.phone,
    this.avatarUrl,
    this.role = 'member',
  });

  // تحويل من Results إلى SelectedMember
  factory SelectedMember.fromResults(Results result, {String role = 'member'}) {
    return SelectedMember(
      id: result.id ?? '',
      email: result.email ?? '',
      displayName: result.displayName ?? '',
      phone: result.phone,
      avatarUrl: result.avatarUrl,
      role: role,
    );
  }

  // تحويل إلى Members للإرسال في API
  Members toMembersRequest() {
    return Members(
      userId: id,
      role: role,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedMember && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  SelectedMember copyWith({
    String? id,
    String? email,
    String? displayName,
    String? phone,
    String? avatarUrl,
    String? role,
  }) {
    return SelectedMember(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
    );
  }
}