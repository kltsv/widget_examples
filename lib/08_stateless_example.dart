import 'package:flutter/material.dart';

const _imageUrl =
    'https://sun9-25.userapi.com/impf/c638318/v638318260/5eca3/i_m2zJ7X8Wc.jpg?size=604x604&quality=96&sign=31cdf5634a675efe6656e5da05b6839b&type=album';

class StatelessExample extends StatelessWidget {
  const StatelessExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
      ),
      body: Body(onAvatarDoubleTap: (context) => showBottomSheet(context)),
      bottomNavigationBar: const BottomMenu(),
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
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('I`m bottom sheet!')),
    );
  }
}

class Body extends StatelessWidget {
  final void Function(BuildContext)? onAvatarDoubleTap;

  const Body({Key? key, this.onAvatarDoubleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Avatar(onAvatarDoubleTap: onAvatarDoubleTap),
          const Content(),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final void Function(BuildContext)? onAvatarDoubleTap;

  const Avatar({Key? key, this.onAvatarDoubleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onDoubleTap: () {
          print('Gesture detector double tap');
          onAvatarDoubleTap?.call(context);
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
    });
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
