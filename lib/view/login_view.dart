import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwy/utils/constants.dart';
import 'package:jwy/view/widgets/reusable_button.dart';
import 'package:jwy/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jwy/view/product_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Consumer<LoginViewModel>(
            builder: (context, loginViewModel, child) {
              if (loginViewModel.isLoggedIn) {
                // Navigate to ProductView after login
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProductView()),
                  );
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/login.png'),
                  Text(
                    'ATTS Jewelry App',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  if (loginViewModel.errorMessage != null)
                    Text(
                      loginViewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),
                  loginViewModel.isLoading
                      ? const CircularProgressIndicator()
                      : ReusableButton(
                        title: 'Login',
                        onPress: () async {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          await loginViewModel.login(email, password);
                        },
                        color: kPrimaryColor,
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
