import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/login_request_model.dart';
import 'package:flutter_app/presentation/screens/auth/signup.dart';
import 'package:flutter_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:flutter_app/presentation/screens/schedules_screen.dart';
import 'package:flutter_app/service/auth_service.dart';

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
          "Добредојдовте",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Внесете ги вашите податоци за да се логирате "),
      ],
    );
  }

  Column _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center ,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: "Корисничко име",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color(0xFF123499).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
          // fillColor:Color(0xFF123499).withOpacity(0.1),
          // filled: true,
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
        // const SizedBox(height: 5),
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
            fillColor:Color(0xFF123499).withOpacity(0.1),
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
                  builder: (context) => SchedulesScreen(initialIndex: 0,),
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
        const Text("Немате корисничка сметка? "),
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