import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_dfine/config/firestore_paths.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';

class FirebaseTodoDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirestorePaths firestorePaths;

  FirebaseTodoDatasource({required this.firebaseFirestore, required this.firebaseAuth,required this.firestorePaths});

  Future<Either<AppExceptions, void>> addCategory(CategoryModel model) async {
    User? user = firebaseAuth.currentUser;
    try {
      if (user != null) {
        await firestorePaths.categoriesCollection(user.uid).add(model.toMap());
        return const Right(null);
      } else {
        return Left(UnauthorizedException());
      }
    } on FirebaseException catch (e) {
      return Left(FirebaseDatabaseException('Firestore error: ${e.message}', e.code));
    } catch (e) {
      return Left(UnknownException());
    }
  }


  Future<Either<AppExceptions,void>> addTodo(String categoryName,TodoModel todoModel)async{
    User ? user=firebaseAuth.currentUser;
    try {
      if(user!=null){
        await firestorePaths.todosCollection(user.uid, categoryName).add(todoModel.toMap());
        return const Right(null);
      }else{
        return Left(UnauthorizedException());
      }
      
    }on FirebaseException catch(e){
      return Left(FirebaseDatabaseException('FireStore error', e.toString()));
    }
    catch (e) {
      return Left(UnknownException());
    }
  }
}

