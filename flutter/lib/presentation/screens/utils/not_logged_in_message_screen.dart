import 'package:flutter/material.dart';
import '../login/auth.dart';

class NotLoggedInMessageScreen extends StatelessWidget {
  const NotLoggedInMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Мора да сте најавени за да ги видите вашите распореди!',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
            child: const Text('Најава'),
          ),
        ],
      ),
    );
  }
}
