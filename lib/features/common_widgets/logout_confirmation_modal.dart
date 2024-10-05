import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_in.dart';

void showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is SignOutSuccess){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
              }
            },
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogoutUserEvent());
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      );
    },
  );
}
