import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/login_request_model.dart';
import '../../../service/auth_service.dart';
import '../../../shared/constants.dart';
import '../../../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn(this.toggleView, {super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: const Text('Sign in'),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Username'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an username' : null,
                          onChanged: (val) {
                            setState(() => username = val);
                          }),
                      const SizedBox(height: 20.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Change the background color here
                          ),
                          onPressed: () async {
                         //    if (_formKey.currentState!.validate()) {
                         //      setState(() => loading = true);
                         // //     dynamic result = await AuthService.login(
                         //          LoginRequestModel(
                         //              username: username, password: password));
                         //      if (result == null) {
                         //        setState(() {
                         //          error =
                         //              'could not sign in with those credentials';
                         //          loading = false;
                         //        });
                         //      }
                          //  }
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )),
          );
  }
}
