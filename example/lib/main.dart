import 'package:flutter/material.dart';
import 'package:musixmatch/musixmatch.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello',
      theme: ThemeData(),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void getSomething() {
    var api = MusixmatchApi('1ae20278a4068889effe93f46beabbad',isLogging: true);
    api.getTrackRaw('hello','adelle');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bonjour musixmatch')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(onPressed: getSomething,child: Text('test'),),

        ],
      )),
    );
  }
}
