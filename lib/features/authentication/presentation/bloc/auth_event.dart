part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class SignUpUserClickedEvent extends AuthEvent{
  final UserModel userModel;
  SignUpUserClickedEvent({required this.userModel});
}

class SignInUserClickedEvent extends AuthEvent{
  final UserModel userModel;
  SignInUserClickedEvent({required this.userModel});
}

class LogoutUserEvent extends AuthEvent{}