part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class SignupSuccess extends AuthState{}
final class SigninSuccess extends AuthState{}
final class AuthenticationLoading extends AuthState{}
final class AuthenticationError extends AuthState{
  final String message;
  AuthenticationError({required this.message});
}