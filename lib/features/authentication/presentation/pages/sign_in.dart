import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/core/validations.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/pages/all_categories_page.dart';
import 'package:machine_test_dfine/features/authentication/data/models/user_model.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_up.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_button.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';
import 'package:machine_test_dfine/features/common_widgets/snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is SigninSuccess){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, 'Login successfull'));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TodoCategoriesPage()));
        }else if(state is AuthenticationError){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, state.message));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Text(
                'Sign In',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      onChanged: (value) =>
                          ValidatorFunctions.validateEmail(value),
                      hintText: 'Email',
                      textEditingController: emailController,
                      validator: (value) =>
                          ValidatorFunctions.validateEmail(value),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Password',
                      textEditingController: passwordController,
                      obscureText: true,
                      validator: (value) =>
                          ValidatorFunctions.validatePassword(value),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: AuthState is AuthenticationLoading,
                          buttonLabel: 'Sign in',
                          ontap: () {
                            if (formKey.currentState!.validate() &&
                                AuthState is! AuthenticationLoading) {
                              BlocProvider.of<AuthBloc>(context).add(
                                SignInUserClickedEvent(
                                  userModel: UserModel(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                ),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'Please check your input'));
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  print("Forgot Password clicked");
                },
                child: const Text("Forgot Password?"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: const Text("Not a uesr? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
