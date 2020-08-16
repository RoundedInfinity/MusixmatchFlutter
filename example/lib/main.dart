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
  var api = MusixmatchApi('1ae20278a4068889effe93f46beabbad', isLogging: true);
  void getSomething() async {
    LyricsData lyricData = await api.getLyrics('Back in Black', 'AC/DC');

    print(lyricData.copyright);
    TrackData trackData = await api.getTrack('Back in Black', 'AC/DC');
    print(trackData.trackName);
  }

  void search() async {
    var query = await api.searchTrack('Bohemian Rhapsody','Queen','mama');
    query.forEach((element) {
      print('${element.trackName} -- ${element.likes}');
    });
    api.getLyrics(query[0].trackName, query[0].artistName).then((value) => print(value.lyricsBody));
  }

  void getById() async {
    var data = await api.getTrackById(84213309);
    print(data.artistName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bonjour musixmatch')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
            onPressed: search,
            child: Text('test'),
          ),
        ],
      )),
    );
  }
}
