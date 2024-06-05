import 'package:flutter/material.dart';
import 'package:simple_app/service/auth_service.dart';
import 'package:simple_app/presentation/screens/auth/login.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return child;
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
