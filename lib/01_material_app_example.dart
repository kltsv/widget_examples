import 'package:flutter/material.dart';

class MaterialAppExample extends StatelessWidget {
  const MaterialAppExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Hello world!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
