import 'package:flutter/material.dart';

class ContainerExample extends StatelessWidget {
  const ContainerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        body: Center(
          child: Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              border: Border.all(width: 5),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            transform: Matrix4.rotationZ(0.1),
            child: const Center(
              child: Text(
                'Hello world!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
