import 'package:doulirouge/view/screens/qa/qa_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // More neutral background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title of the app
              Text(
                '📚 English Test',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70, // Subtle, educational feel
                ),
              ),
              SizedBox(height: 15),
              // Subtitle with instructional text
              Text(
                'Test your English skills and improve your vocabulary!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white54, // Light text for instructions
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              // Start button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QAScreen()),
                  );
                  // Navigate to the QA screen to start the test
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Lighter accent color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 5, // Add shadow for a more elevated look
                ),
                child: Text(
                  'Start Test',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
              // Optional footer or extra information
              Text(
                'Good luck and have fun!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54, // Soft footer text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
