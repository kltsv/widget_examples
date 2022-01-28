import 'package:flutter/material.dart';

const _imageUrl =
    'https://sun9-25.userapi.com/impf/c638318/v638318260/5eca3/i_m2zJ7X8Wc.jpg?size=604x604&quality=96&sign=31cdf5634a675efe6656e5da05b6839b&type=album';

class ListViewExample extends StatelessWidget {
  const ListViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class BottomMenu extends StatefulWidget {
  final int page;
  final ValueChanged<int>? onChanged;

  const BottomMenu({
    Key? key,
    required this.page,
    this.onChanged,
  }) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  bool _advanced = false;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = widget.page;
  }

  @override
  void didUpdateWidget(covariant BottomMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page != widget.page) {
      _selected = widget.page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.page,
      onTap: (index) {
        setState(() {
          if (index == widget.page) {
            _advanced = !_advanced;
          }
        });
        widget.onChanged?.call(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
              _advanced && _selected == 0 ? Icons.home : Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(_advanced && _selected == 1
              ? Icons.person
              : Icons.person_outline),
          label: 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(_advanced && _selected == 2
              ? Icons.settings
              : Icons.settings_outlined),
          label: 'Settings',
        ),
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
  late final PageController _pageController;
  var _page = 0;

  @override
  void initState() {
    super.initState();
    _page = _storage.loadPage();
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetProvider(
      manager: BottomSheetManager(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: onChanged,
          scrollDirection: Axis.vertical,
          children: const [
            HomeBody(),
            UserBody(),
            SettingsBody(),
          ],
        ),
        bottomNavigationBar: BottomMenu(
          page: _page,
          onChanged: (index) {
            changePage(index);
            onChanged(index);
          },
        ),
        drawer: const Drawer(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print('Floating action button has been pressed');
              BottomSheetProvider.of(context)?.show(context);
            },
          );
        }),
      ),
    );
  }

  void onChanged(int index) => setState(() => _page = index);

  void changePage(int index) {
    print('Jump to: $index');
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}

class HomeBody extends StatelessWidget {
  static final items = List.generate(
    100,
    (index) => index * 10,
  ).toList();

  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map((e) => HomeListTile(value: e.toString())).toList(),
    );
    // return ListView.builder(
    //   itemCount: items.length,
    //   itemBuilder: (context, index) => HomeListTile(
    //     value: items[index].toString(),
    //   ),
    // );
  }
}

class HomeListTile extends StatelessWidget {
  final String value;

  HomeListTile({Key? key, required this.value}) : super(key: key) {
    print('created: $value');
  }

  @override
  Widget build(BuildContext context) {
    print(value);
    return ListTile(
      title: Text(value),
      subtitle: Text(value.hashCode.toString()),
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(_text, style: TextStyle(fontSize: 36)),
        ),
      ),
    );
  }
}

class UserBody extends StatelessWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Avatar(),
          Content(),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onDoubleTap: () {
          print('Gesture detector double tap');
          BottomSheetProvider.of(context)?.show(context);
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

class BottomSheetManager {
  void show(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => const Center(child: Text('I`m bottom sheet!')),
      );
}

class BottomSheetProvider extends InheritedWidget {
  final BottomSheetManager manager;

  const BottomSheetProvider({
    Key? key,
    required Widget child,
    required this.manager,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant BottomSheetProvider oldWidget) =>
      oldWidget.manager != manager;

  static BottomSheetManager? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BottomSheetProvider>()
      ?.manager;
}

const _text = '''
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   

Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet''';
