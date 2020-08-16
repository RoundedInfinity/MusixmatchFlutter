import 'package:flutter/widgets.dart';

class LyricsData {
  final String lyricsBody;
  final String copyright;
  final int id;
  final int explicit;

  LyricsData(
      {this.copyright,
      @required this.id,
      this.explicit,
      @required this.lyricsBody});
}
