import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';
const String foursquareApiKey = '';
Future<void> main() async {
  // Load .env
  // await dotenv.load(fileName: ".env");

  runApp(const FusionCardsApp());
}

class FusionCardsApp extends StatelessWidget {
  const FusionCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FusionCards Hackathon',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
