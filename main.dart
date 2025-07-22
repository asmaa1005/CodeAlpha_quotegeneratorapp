import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // updated class name
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // added key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const QuoteScreen(), // added const and key
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key}); // added key

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {
      'quote': 'The best way to get started is to quit talking and begin doing.',
      'author': 'Walt Disney'
    },
    {
      'quote': 'Success is not final; failure is not fatal: It is the courage to continue that counts.',
      'author': 'Winston Churchill'
    },
    {
      'quote': 'Don’t let yesterday take up too much of today.',
      'author': 'Will Rogers'
    },
    {
      'quote': 'It’s not whether you get knocked down, it’s whether you get up.',
      'author': 'Vince Lombardi'
    },
    {
      'quote': 'If you are working on something exciting, it will keep you motivated.',
      'author': 'Steve Jobs'
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    final quote = quotes[currentIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Random Quote'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.format_quote, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 30),
              Text(
                '"${quote['quote']}"',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Text(
                "- ${quote['author']}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: getRandomQuote,
                icon: const Icon(Icons.refresh),
                label: const Text("New Quote"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
