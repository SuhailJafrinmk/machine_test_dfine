import 'package:flutter/material.dart';
import 'package:machine_test_dfine/core/validations.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_button.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';

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
    // Dispose controllers to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Add space from the top
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.bodyMedium, // Use theme text style
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Email',
                    textEditingController: emailController,
                    validator: (value) => ValidatorFunctions.validateEmail(value),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Password',
                    textEditingController: passwordController,
                    obscureText: true, // Hide the password text
                    validator: (value) => ValidatorFunctions.validatePassword(value),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Sign In',
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        // If form is valid, proceed to sign in
                        _handleSignIn();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add forgot password functionality here
                print("Forgot Password clicked");
              },
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn() {
    // Perform sign-in logic here
    final email = emailController.text;
    final password = passwordController.text;

    // Add your sign-in logic with Firebase or backend here
    print('Email: $email, Password: $password');
  }
}
