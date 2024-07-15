import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/login_request_model.dart';
import 'package:flutter_app/presentation/screens/auth/signup.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:flutter_app/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/schedule_provider.dart';

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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            bool isDefault = Provider.of<ScheduleProvider>(context, listen: false).isDefault;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(initialIndex: isDefault ? 0 : 1),
              ),
            );
          },
        ),
        title: const Text('Распореди'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Form(
                key: globalFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _header(context),
                    const SizedBox(height: 20),
                    _inputField(context),
                    const SizedBox(height: 20),
                    _loginButton(context),
                    const SizedBox(height: 20),
                    _signup(context),
                  ],
                ),
              ),
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
          "Добредојдовте",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), // Reduced font size
        ),
        Text("Внесете ги вашите податоци за да се логирате"),
      ],
    );
  }

  Column _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: "Корисничко име",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color(0xFF123499).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ве молиме внесете го вашето корисничко име';
            }
            return null;
          },
          onChanged: (val) {
            setState(() => username = val);
          },
        ),
        if (error.isNotEmpty) _showErrorMessage(),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Лозинка",
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color(0xFF123499).withOpacity(0.1),
            filled: true,
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
              return 'Ве молиме внесете ја вашата лозинка';
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
                  builder: (context) => const MainScreen(initialIndex: 0),
                ),
              );
            } else {
              setState(() {
                error = 'Невалидно корисничко име или лозинка';
              });
            }
          } catch (e) {
            setState(() {
              isApiCallProcess = false;
              error = 'Неуспешно логирање: $e';
            });
          }
        }
      },
      child: const Text("Логирај се"),
    );
  }

  Row _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Text("Немате корисничка сметка? "),
        ),
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
            "Регистрирај се",
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
