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
      debugShowCheckedModeBanner: false,
      title: 'Word Pair Generator',
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
        centerTitle: true,
        title: const Text(
          'Word Pair Generator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: selectedIndex == 0
          ? _buildHomePage()
          : _buildFavoritesPage(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 60,
            ),

            const SizedBox(height: 20),

            const Text(
              'Discover a new word pair',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              'Generate creative word combinations and save your favourites.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            BigCard(
              wordPair: currentWordPair,
            ),

            const SizedBox(height: 20),

            IconButton(
              onPressed: toggleFavorite,
              tooltip: isFavorite
                  ? 'Remove from favorites'
                  : 'Add to favorites',
              iconSize: 42,
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: generateWordPair,
              icon: const Icon(Icons.refresh),
              label: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesPage() {
    if (favorites.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Favourite a word pair and it will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${favorites.length} favorite${favorites.length == 1 ? '' : 's'}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.delete,
                  ),
                ),

                secondaryBackground: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                  ),
                ),

                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.favorite,
                    ),
                    title: Text(
                      favorite,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Swipe to remove',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 28,
        ),
        child: Text(
          wordPair,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}