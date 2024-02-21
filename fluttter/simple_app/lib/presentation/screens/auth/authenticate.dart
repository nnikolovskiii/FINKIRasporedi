import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/auth/register.dart';
import 'package:simple_app/presentation/screens/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
   if (showSignIn) {
     return SignIn();
   } else {
     return Register(toggleView);
   }
  }
}