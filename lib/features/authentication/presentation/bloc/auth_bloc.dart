import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpUserClickedEvent>(signUpUserClickedEvent);
    on<SignInUserClickedEvent>(signInUserClickedEvent);

  }

  FutureOr<void> signUpUserClickedEvent(SignUpUserClickedEvent event, Emitter<AuthState> emit) {
  
  }

  FutureOr<void> signInUserClickedEvent(SignInUserClickedEvent event, Emitter<AuthState> emit)async{
    final response=await authRepository.signInWithEmailAndPassword(event.userEmail, event.password);
    response.fold(
      ifLeft: (failure){

      },
      ifRight: (success){

      });
  }
}
