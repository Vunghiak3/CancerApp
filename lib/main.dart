import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testfile/ui/welcompage/welcome.dart';

void main() {
  runApp(const ProviderScope(child: CancerApp()));
}

class CancerApp extends StatelessWidget {
  const CancerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cancer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
