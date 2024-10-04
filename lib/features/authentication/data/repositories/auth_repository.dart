
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_dfine/core/custom_types.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';

abstract class AuthRepository{
  EitherResponse signInWithEmailAndPassword(String userName,String password);
}