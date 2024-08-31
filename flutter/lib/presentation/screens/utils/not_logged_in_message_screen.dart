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
              'Најавете се за да ги видите вашите распореди!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF375e94),
                              fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF375e94)),
            ),
            child: const Text('Најава',
            style: TextStyle(color: Colors.white),),
          ),

        ],
      ),
    );
  }
}
