import 'package:flutter/material.dart';
import '../auth/login.dart';

class NotLoggedInMessageScreen extends StatelessWidget {
  const NotLoggedInMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center( // Wrap the Text widget with Center
            child: const Text(
              'Мора да сте логирани за да си видите вашите распореди!',
              textAlign: TextAlign.center, // Ensure the text is centered
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Логирај се'),
          ),
        ],
      ),
    );
  }
}
