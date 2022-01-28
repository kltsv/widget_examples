import 'package:flutter/material.dart';

const _imageUrl =
    'https://sun9-25.userapi.com/impf/c638318/v638318260/5eca3/i_m2zJ7X8Wc.jpg?size=604x604&quality=96&sign=31cdf5634a675efe6656e5da05b6839b&type=album';

class StatefulExample extends StatelessWidget {
  const StatefulExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final int page;
  final ValueChanged<int>? onChanged;

  const BottomMenu({
    Key? key,
    required this.page,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: page,
      onTap: onChanged,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage _storage = Storage();
  var _page = 0;

  @override
  void initState() {
    super.initState();
    _page = _storage.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
      ),
      body: _bodyPage(_page),
      bottomNavigationBar: BottomMenu(
        page: _page,
        onChanged: onChanged,
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
    );
  }

  void onChanged(int index) => setState(() => _page = index);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('I`m bottom sheet!')),
    );
  }

  Widget _bodyPage(int page) {
    switch (page) {
      case 0:
        return const HomeBody();
      case 1:
        return UserBody(
            onAvatarDoubleTap: (context) => showBottomSheet(context));
      case 2:
        return const SettingsBody();
    }
    throw Exception('Unknown page');
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home'));
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings'));
  }
}

class UserBody extends StatelessWidget {
  final void Function(BuildContext)? onAvatarDoubleTap;

  const UserBody({Key? key, this.onAvatarDoubleTap}) : super(key: key);

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

class Storage {
  int loadPage() => 1;
}
