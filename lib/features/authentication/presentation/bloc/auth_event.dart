part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class SignUpUserClickedEvent extends AuthEvent{
  final String email;
  final String userName;
  final String password;
  SignUpUserClickedEvent({required this.email, required this.userName, required this.password});
}

class SignInUserClickedEvent extends AuthEvent{
  final String userEmail;
  final String password;
  SignInUserClickedEvent({required this.userEmail, required this.password});

}