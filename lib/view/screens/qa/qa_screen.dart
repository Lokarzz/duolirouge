import 'dart:convert';
import 'package:doulirouge/model/data/question.dart';
import 'package:doulirouge/view/screens/failure/failure_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({super.key});

  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  int? selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String jsonString = await rootBundle.loadString(
      'assets/json/questions.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      questions =
          jsonData
              .map(
                (q) => Question(
                  text: q['text'],
                  options: List<String>.from(q['options']),
                  correctAnswerIndex: q['correctAnswerIndex'],
                ),
              )
              .toList();

      // Shuffle the questions
      questions.shuffle();
    });
  }

  void onOptionSelected(int index) {
    setState(() {
      selectedOptionIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (questions.isEmpty) return;

      if (index == questions[currentIndex].correctAnswerIndex) {
        if (currentIndex + 1 < questions.length) {
          setState(() {
            currentIndex++;
            selectedOptionIndex = null;
          });
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('🎉 Quiz Completed!')));
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FailureScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        // title: Text('Question ${currentIndex + 1}/${questions.length}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ...List.generate(question.options.length, (index) {
              final isSelected = index == selectedOptionIndex;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? Colors.blueAccent : Colors.grey[800],
                    foregroundColor: isSelected ? Colors.white : Colors.white70,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => onOptionSelected(index),
                  child: Text(
                    question.options[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
