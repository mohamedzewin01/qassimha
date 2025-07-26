part of 'Auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoginLoading extends AuthState {}
final class AuthLoginSuccess extends AuthState {
final  AuthWithGoogleEntity? userEntity;
  AuthLoginSuccess(this.userEntity);
}
final class AuthLoginFailure extends AuthState {
  final Exception exception;

  AuthLoginFailure(this.exception);
}

