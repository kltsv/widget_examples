import 'package:flutter/material.dart';
import 'package:widgets_examples/14_future_stream_builder_example.dart';

void main() => runApp(const FutureStreamBuilderExample());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Hello World!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DataProvider extends InheritedWidget {
  const DataProvider({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final String data;

  static String? of(BuildContext context) {
    final DataProvider? result =
        context.dependOnInheritedWidgetOfExactType<DataProvider>();
    return result?.data;
  }

  @override
  bool updateShouldNotify(DataProvider oldWidget) => data != oldWidget.data;
}
