import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/pages/all_categories_page.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_in.dart';

class UtilityFunctions {
static Widget checkLogin(){
  User ? user=FirebaseAuth.instance.currentUser;
  if(user!=null){
    return TodoCategoriesPage();
  }else{
    return SignInPage();
  }
}

}