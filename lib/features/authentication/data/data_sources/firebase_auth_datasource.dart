import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  FirebaseAuthDatasource({required this.firebaseAuth,required this.firebaseFirestore});
  Future<UserModel?> signInWithEmailAndPassword(String email,String password)async{
    try {
      UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User ? user=userCredential.user;
      if(user!=null){
       UserModel userModel=UserModel(id: user.uid,email: user.email ?? '',name: user.displayName ?? '');
       firebaseFirestore.collection('USERS').doc(user.uid).set(userModel.toJson());
       return UserModel(id: user.uid, email: user.email ?? '', name: user.displayName ?? '');
      }
    } catch (e) {
      print('error occured ${e.toString()}');
    }
  }
}