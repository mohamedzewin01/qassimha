part of 'members_cubit.dart';

@immutable
sealed class MembersState {}

final class MembersInitial extends MembersState {}
final class GetMembersLoading extends MembersState {}

final class GetMembersSuccess extends MembersState {
  final GetMembersEntity getMembersEntity;

  GetMembersSuccess(this.getMembersEntity);
}

final class GetMembersFailure extends MembersState {
  final Exception exception;

  GetMembersFailure(this.exception);
}
