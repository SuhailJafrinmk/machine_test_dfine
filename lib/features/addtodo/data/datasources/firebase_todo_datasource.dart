import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_dfine/config/firestore_paths.dart';
import 'package:machine_test_dfine/core/custom_types.dart';
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

 Future<Either<AppExceptions,List<CategoryModel>>> getCategories() async {
  User? user = firebaseAuth.currentUser;
  if (user == null) {
    return Left(AppExceptions(errorMessage: 'user not logged in'));
  }
  try {
    final response = await firestorePaths.categoriesCollection(user.uid).get();
    List<CategoryModel> categories = response.docs.map((doc) {
      return CategoryModel.fromMap(doc.data() as Map<String,dynamic>);
    }).toList();

    return Right(categories); 

  } catch (e) {
    return Left(AppExceptions(errorMessage: e.toString()));
  }
}

 Future<Either<AppExceptions,List<TodoModel>>> getTodos(String categoryName) async {
  User? user = firebaseAuth.currentUser;
  if (user == null) {
    return Left(AppExceptions(errorMessage: 'user not logged in'));
  }
  try {
    final response = await firestorePaths.todosCollection(user.uid, categoryName).get();
    List<TodoModel> categories = response.docs.map((doc) {
      return TodoModel.fromMap(doc.data() as Map<String,dynamic>);
    }).toList();
    return Right(categories); 

  } catch (e) {
    return Left(AppExceptions(errorMessage: e.toString()));
  }
}


}

