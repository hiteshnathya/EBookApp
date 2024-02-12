import 'package:ebook/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( EBook());
}

class EBook extends StatelessWidget {
  const EBook({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
