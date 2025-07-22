import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Main app with theme toggle
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: QuoteScreen(toggleTheme: toggleTheme, themeMode: _themeMode),
    );
  }
}

// Quote screen with state
class QuoteScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  const QuoteScreen({super.key, required this.toggleTheme, required this.themeMode});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {'quote': 'The best way to get started is to quit talking and begin doing.', 'author': 'Walt Disney'},
    {'quote': 'Success is not final; failure is not fatal: It is the courage to continue that counts.', 'author': 'Winston Churchill'},
    {'quote': 'Don’t let yesterday take up too much of today.', 'author': 'Will Rogers'},
    {'quote': 'It’s not whether you get knocked down, it’s whether you get up.', 'author': 'Vince Lombardi'},
    {'quote': 'If you are working on something exciting, it will keep you motivated.', 'author': 'Steve Jobs'},
    {'quote': 'Life is what happens when you’re busy making other plans.', 'author': 'John Lennon'},
    {'quote': 'You miss 100% of the shots you don’t take.', 'author': 'Wayne Gretzky'},
    {'quote': 'Whether you think you can or you think you can’t, you’re right.', 'author': 'Henry Ford'},
    {'quote': 'I have not failed. I’ve just found 10,000 ways that won’t work.', 'author': 'Thomas Edison'},
    {'quote': 'Keep your face always toward the sunshine—and shadows will fall behind you.', 'author': 'Walt Whitman'},
  ];

  final List<Map<String, String>> favoriteQuotes = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  void getRandomQuote() {
    final random = Random();
    setState(() {
      currentIndex = random.nextInt(quotes.length);
    });
  }

  void saveToFavorites() {
    final currentQuote = quotes[currentIndex];
    if (!favoriteQuotes.contains(currentQuote)) {
      setState(() {
        favoriteQuotes.add(currentQuote);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quote saved to favorites!')),
      );
    }
  }

  void openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FavoritesScreen(favorites: favoriteQuotes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quote = quotes[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: openFavorites,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(Icons.format_quote, size: 40, color: Colors.grey.shade400),
                      const SizedBox(height: 20),
                      Text(
                        '"${quote['quote']}"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Georgia',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '- ${quote['author']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: getRandomQuote,
                    icon: const Icon(Icons.refresh),
                    label: const Text("New Quote"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: saveToFavorites,
                    icon: const Icon(Icons.favorite),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Favorites screen
class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite quotes yet.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final quote = favorites[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"${quote['quote']}"',
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "- ${quote['author']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
