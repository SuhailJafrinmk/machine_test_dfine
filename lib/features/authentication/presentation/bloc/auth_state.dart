part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

 class AuthInitial extends AuthState {}
 class SignupSuccess extends AuthState{}
 class SigninSuccess extends AuthState{}
 class AuthenticationLoading extends AuthState{}
 class AuthenticationError extends AuthState{
  final String message;
  AuthenticationError({required this.message});
}
class SignOutSuccess extends AuthState{}
