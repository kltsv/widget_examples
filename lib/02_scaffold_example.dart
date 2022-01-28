import 'package:flutter/material.dart';

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        body: const Center(
          child: Text(
            'Hello world!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        drawer: const Drawer(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print('Floating action button has been pressed');
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    const Center(child: Text('I`m bottom sheet!')),
              );
            },
          );
        }),
      ),
    );
  }
}
