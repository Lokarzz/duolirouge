import 'package:flutter/material.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wrong Answer!',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Back to Start'),
            ),
          ],
        ),
      ),
    );
  }
}
