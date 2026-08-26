import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> adjectives = [
    'Happy',
    'Brave',
    'Bright',
    'Calm',
    'Creative',
    'Friendly',
  ];

  final List<String> nouns = [
    'Mountain',
    'River',
    'Garden',
    'Ocean',
    'Forest',
    'Sun',
  ];

  String currentWordPair = 'Happy Mountain';

  void generateWordPair() {
    final random = Random();

    final adjective =
        adjectives[random.nextInt(adjectives.length)];

    final noun =
        nouns[random.nextInt(nouns.length)];

    setState(() {
      currentWordPair = '$adjective $noun';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Namer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your word pair is:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              currentWordPair,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: generateWordPair,
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}