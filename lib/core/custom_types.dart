import 'package:dart_either/dart_either.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';

typedef EitherResponse = Future<Either<AppExceptions, UserModel>>;