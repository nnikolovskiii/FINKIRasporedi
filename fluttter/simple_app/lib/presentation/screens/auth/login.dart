import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/login_request_model.dart';
import 'package:simple_app/presentation/screens/auth/signup.dart';
import 'package:simple_app/presentation/screens/schedules_screen.dart';
import 'package:simple_app/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _loginButton(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  Column _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Username",
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
          onChanged: (val) {
            setState(() => username = val);
          },
        ),
        const SizedBox(height: 5),
        if (error.isNotEmpty) _showErrorMessage(),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          obscureText: hidePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          onChanged: (val) {
            setState(() => password = val);
          },
        ),
      ],
    );
  }

  ElevatedButton _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (globalFormKey.currentState!.validate()) {
          globalFormKey.currentState!.save();

          setState(() {
            isApiCallProcess = true;
          });

          try {
            dynamic result = await AuthService.login(
              LoginRequestModel(
                username: username,
                password: password,
              ),
            );

            setState(() {
              isApiCallProcess = false;
            });

            if (result == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SchedulesScreen(initialIndex: 1,),
                ),
              );
            } else {
              setState(() {
                error = 'Invalid username or password';
              });
            }
          } catch (e) {
            setState(() {
              isApiCallProcess = false;
              error = 'Failed to login: $e';
            });
          }
        }
      },
      child: const Text("Login"),
    );
  }

  Row _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _showErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
