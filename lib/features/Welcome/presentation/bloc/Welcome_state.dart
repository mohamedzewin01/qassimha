part of 'Welcome_cubit.dart';

@immutable
sealed class WelcomeState {}

final class WelcomeInitial extends WelcomeState {}
final class WelcomeLoading extends WelcomeState {}
final class WelcomeSuccess extends WelcomeState {}
final class WelcomeFailure extends WelcomeState {
  final Exception exception;

  WelcomeFailure(this.exception);
}
