import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_dfine/config/firestore_paths.dart';
import 'package:machine_test_dfine/core/custom_types.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirestorePaths firestorePaths;
  FirebaseAuthDatasource({required this.firebaseAuth,required this.firebaseFirestore,required this.firestorePaths});
  EitherResponse signInWithEmailAndPassword(UserModel userModel)async{
    try {
      UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password!);
      User ? user=userCredential.user;
      if(user!=null){
       UserModel userModel=UserModel(id: user.uid,email: user.email ?? '',name: user.displayName ?? '');
       return Right(userModel);
      }
      return Left(AppExceptions(errorMessage: 'User not authorized'));
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }


  EitherResponse createUserWithEmailAndPassword(UserModel userModel) async {
  try {
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email, 
      password: userModel.password!,
    );
    User? user = userCredential.user;
    if (user != null) {
      UserModel newUser = UserModel(
        id: user.uid, 
        email: user.email ?? '', 
        name: userModel.name,
      );
      await firestorePaths.userDocument(user.uid).set(newUser.toJson());
      return Right(newUser);
    }
    return Left(AppExceptions(errorMessage: 'User creation failed'));
  } catch (e) {
    return Left(AppExceptions(errorMessage: e.toString()));
  }
}

Future<Either<AppExceptions, void>> logoutUser() async {
  User? user = firebaseAuth.currentUser;
  if (user == null) {
    return Left(AppExceptions(errorMessage: 'User not logged in'));
  }
  try {
    await firebaseAuth.signOut();
    return const Right(null); // Corrected: Ensure Right is returned
  } catch (e) {
    return Left(AppExceptions(errorMessage: e.toString()));
  }
}

}