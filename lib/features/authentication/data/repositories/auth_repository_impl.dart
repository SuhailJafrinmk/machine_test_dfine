import 'package:dart_either/src/dart_either.dart';
import 'package:machine_test_dfine/core/custom_types.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/authentication/data/data_sources/firebase_auth_datasource.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuthDatasource firebaseAuthDatasource;
  AuthRepositoryImpl({required this.firebaseAuthDatasource});
  @override
  EitherResponse signInWithEmailAndPassword(UserModel userModel) {
  return firebaseAuthDatasource.signInWithEmailAndPassword(userModel);
  }

  @override
  EitherResponse createUserWithEmailAndPassword(UserModel userModel) {
    return firebaseAuthDatasource.createUserWithEmailAndPassword(userModel);
  }

  @override
  Future<Either<AppExceptions, void>> logoutUser() {
    return firebaseAuthDatasource.logoutUser();
  }
}