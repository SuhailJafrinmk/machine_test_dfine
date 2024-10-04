
import 'package:machine_test_dfine/core/custom_types.dart';

abstract class AuthRepository{
  EitherResponse signInWithEmailAndPassword(String userName,String password);
}