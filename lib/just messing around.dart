import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'color_provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ColorProvider(),
        child: MeineApp(),
      ),
    );

class MeineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meine App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meine App'),
        ),
        body: Consumer<ColorProvider>(
          builder: (context, colorProvider, _) => Container(
            color: colorProvider.backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Aktuelle Hintergrundfarbe:',
                  ),
                  Text(
                    colorProvider.backgroundColor.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZweiterScreen(),
              ),
            );
          },
          child: Icon(Icons.color_lens),
        ),
      ),
    );
  }
}

class ZweiterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zweiter Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                var colorProvider =
                    Provider.of<ColorProvider>(context, listen: false);
                colorProvider.changeBackgroundColor(Colors.red);
              },
              child: Text('Hintergrundfarbe Ã¤ndern'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorProvider with ChangeNotifier {
  Color _backgroundColor = Colors.white;

  Color get backgroundColor => _backgroundColor;

  void changeBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}
