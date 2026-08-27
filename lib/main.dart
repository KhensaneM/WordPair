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

  int selectedIndex = 0;

  void generateWordPair() {
    final random = Random();

    final adjective =
        adjectives[random.nextInt(adjectives.length)];

    final noun =
        nouns[random.nextInt(nouns.length)];

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

  void removeFavorite(int index) {
    final removedFavorite = favorites[index];

    setState(() {
      favorites.removeAt(index);

      if (removedFavorite == currentWordPair) {
        isFavorite = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$removedFavorite removed from favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: selectedIndex == 0
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    'Your word pair is:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  BigCard(
                    wordPair: currentWordPair,
                  ),

                  const SizedBox(height: 20),

                  IconButton(
                    onPressed: toggleFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    iconSize: 40,
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: generateWordPair,
                    child: const Text('Generate'),
                  ),
                ],
              ),
            )
          : favorites.isEmpty
              ? const Center(
                  child: Text(
                    'No favorites yet.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];

                    return Dismissible(
                      key: ValueKey(favorite),

                      direction: DismissDirection.horizontal,

                      onDismissed: (direction) {
                        removeFavorite(index);
                      },

                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),

                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),

                      child: ListTile(
                        leading: const Icon(
                          Icons.favorite,
                        ),
                        title: Text(favorite),
                      ),
                    );
                  },
                ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.favorite_border,
            ),
            selectedIcon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
        ],
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
          style: Theme.of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
    );
  }
}