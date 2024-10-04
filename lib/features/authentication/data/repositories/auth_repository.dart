
import 'package:dart_either/dart_either.dart';
import 'package:machine_test_dfine/core/custom_types.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';

abstract class AuthRepository{
  EitherResponse signInWithEmailAndPassword(UserModel usermodel);
  EitherResponse createUserWithEmailAndPassword(UserModel userModel);
}