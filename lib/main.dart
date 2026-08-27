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
      ),
      home: const MyHomePage(title: 'Namer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> adjectives = [
    'Happy',
    'Brave',
    'Bright',
    'Calm',
    'Clever',
    'Friendly',
    'Lucky',
    'Mighty',
  ];

  final List<String> nouns = [
    'Mountain',
    'Ocean',
    'Forest',
    'River',
    'Sun',
    'Star',
    'Cloud',
    'Garden',
  ];

  String currentWordPair = 'Happy Mountain';

  bool isFavorite = false;

  final List<String> favorites = [];

  void generateWordPair() {
    final random = Random();

    final adjective =
        adjectives[random.nextInt(adjectives.length)];

    final noun = nouns[random.nextInt(nouns.length)];

    setState(() {
      currentWordPair = '$adjective $noun';
      isFavorite = favorites.contains(currentWordPair);
    });
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favorites.remove(currentWordPair);
        isFavorite = false;
      } else {
        favorites.add(currentWordPair);
        isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Your word pair is:',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            BigCard(wordPair: currentWordPair),

            IconButton(
              onPressed: toggleFavorite,
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Favorites',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            favorites.isEmpty
                ? const Text(
                    'No favorites yet.',
                  )
                : Column(
                    children: favorites.map((favorite) {
                      return ListTile(
                        leading: const Icon(Icons.favorite),
                        title: Text(favorite),
                      );
                    }).toList(),
                  ),

            const SizedBox(height: 20),

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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.wordPair,
  });

  final String wordPair;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          wordPair,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}