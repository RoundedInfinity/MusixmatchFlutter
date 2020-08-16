import 'package:http/http.dart' as http;
import 'package:musixmatch/logger.dart';
import 'package:musixmatch/validator.dart';

import 'models/lyrics.dart';
import 'models/lyrics.g.dart';
import 'models/track.g.dart';

class MusixmatchApi {
  final bool isLogging;
  Validator _validator = Validator();
  Logger l = Logger();
  String baseUrl = 'https://api.musixmatch.com/ws/1.1/';
  final String token;

  MusixmatchApi(this.token, {this.isLogging = false});

  Future<LyricDataRaw> getLyricsRaw(String track, String artist) async {
    final response = await http.get(
      '${baseUrl}matcher.lyrics.get?format=jsonp&callback=callback&q_track=$track&q_artist=$artist&apikey=$token',
    );
    if (response == null) return null;

    final lyricSong =
        lyricSongFromJson(response.body.substring(9, response.body.length - 2));
    _validator.validateStatus(lyricSong.message.header.statusCode);
    if (isLogging) l.log('Got Raw lyrics for $track');
    return lyricSong;
  }

  Future<TrackDataRaw> getTrackRaw(String track, String artist) async {
    final response = await http.get(
      '${baseUrl}matcher.track.get?format=jsonp&callback=callback&q_track=$track&q_artist=$artist&apikey=$token',
    );
    if (response == null) return null;

    final trackSong =
        trackFromJson(response.body.substring(9, response.body.length - 2));
    _validator.validateStatus(trackSong.message.header.statusCode);
    if (isLogging)
      l.log('Got Raw Track for ${trackSong.message.body.track.trackName}');
    return trackSong;
  }

  Future<LyricsData> getLyrics(String track, String artist) async {
    var data = await getLyricsRaw(track, artist);

    return LyricsData(
        lyricsBody: data.message.body.lyrics.lyricsBody,
        id: data.message.body.lyrics.lyricsId,
        copyright: data.message.body.lyrics.lyricsCopyright,
        explicit: data.message.body.lyrics.explicit);
  }

  void setValidationLogger(bool isEnabled) {
    _validator.isLogging = isEnabled;
  }
}
