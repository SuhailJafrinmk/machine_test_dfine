import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/core/validations.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_in.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_button.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Create an Account',
              style: Theme.of(context).textTheme.displayLarge, 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'User name',
                    textEditingController: userNameController,
                    validator: (value) => ValidatorFunctions.validateUsername(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Email',
                    textEditingController: emailController,
                    validator: (value) => ValidatorFunctions.validateEmail(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Password',
                    textEditingController: passwordController,
                    obscureText: true, 
                    validator: (value) => ValidatorFunctions.validatePassword(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Confirm password',
                    textEditingController: confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return ValidatorFunctions.validatePassword(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    buttonLabel: 'Sign up',
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignUpUserClickedEvent(
                            userModel: UserModel(
                              email: emailController.text.trim(),
                              name: userNameController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
                    },
                    child: const Text(
                      "Already a user? Sign in",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
