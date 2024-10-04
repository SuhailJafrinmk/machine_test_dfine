import 'package:machine_test_dfine/features/authentication/data/data_sources/firebase_auth_datasource.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuthDatasource firebaseAuthDatasource;
  AuthRepositoryImpl({required this.firebaseAuthDatasource});
  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) {
  return firebaseAuthDatasource.signInWithEmailAndPassword(email, password);
  }
}