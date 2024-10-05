import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';
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
    on<LogoutUserEvent>(logoutUserEvent);

  }

  FutureOr<void> signUpUserClickedEvent(SignUpUserClickedEvent event, Emitter<AuthState> emit)async{
    emit(AuthenticationLoading());
    final response=await authRepository.createUserWithEmailAndPassword(event.userModel);
    response.fold(
      ifLeft: (failure){
        emit(AuthenticationError(message: failure.errorMessage));
      }, 
      ifRight: (success){
        emit(SignupSuccess());
      });

  
  }

  FutureOr<void> signInUserClickedEvent(SignInUserClickedEvent event, Emitter<AuthState> emit)async{
    emit(AuthenticationLoading());
    final response=await authRepository.signInWithEmailAndPassword(event.userModel);
    response.fold(
      ifLeft: (failure){
        emit(AuthenticationError(message: failure.errorMessage));
      },
      ifRight: (success){
        emit(SigninSuccess());
      });
  }


  FutureOr<void> logoutUserEvent(LogoutUserEvent event, Emitter<AuthState> emit)async{
    final response=await authRepository.logoutUser();
    response.fold(
      ifLeft: (failure){
        emit(AuthenticationError(message: failure.errorMessage));
      },
      ifRight: (success){
        emit(SignOutSuccess());
      });
  }
}
