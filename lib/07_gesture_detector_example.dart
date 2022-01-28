import 'package:flutter/material.dart';

const _imageUrl =
    'https://sun9-25.userapi.com/impf/c638318/v638318260/5eca3/i_m2zJ7X8Wc.jpg?size=604x604&quality=96&sign=31cdf5634a675efe6656e5da05b6839b&type=album';

class GestureDetectorExample extends StatelessWidget {
  const GestureDetectorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(builder: (context) {
                return GestureDetector(
                  onDoubleTap: () {
                    print('Gesture detector double tap');
                    showBottomSheet(context);
                  },
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
                    child: ClipRRect(
                      child: Image.network(_imageUrl, fit: BoxFit.fill),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                );
              }),
              Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  border: Border.all(width: 5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                transform: Matrix4.rotationZ(-0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Hello Dart!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(48.0),
                      child: Text(
                        'Hello Flutter!',
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              showBottomSheet(context);
            },
          );
        }),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('I`m bottom sheet!')),
    );
  }
}
