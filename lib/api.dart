import 'package:http/http.dart' as http;
import 'package:musixmatch/logger.dart';
import 'package:musixmatch/validator.dart';

import 'models/lyrics.dart';
import 'models/lyrics.g.dart';
import 'models/track.dart';
import 'models/track.g.dart';
import 'models/track_search_data.g.dart';

class MusixmatchApi {
  final bool isLogging;
  Validator _validator = Validator();
  Logger l = Logger();
  String baseUrl = 'https://api.musixmatch.com/ws/1.1/';
  final String token;

  MusixmatchApi(this.token, {this.isLogging = false});
  Future<bool> testBool() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

//---LYRICS---
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

  Future<LyricsData> getLyrics(String track, String artist) async {
    var data = await getLyricsRaw(track, artist);
    if (isLogging) l.log('Got lyrics for $track');
    return LyricsData(
        lyricsBody: data.message.body.lyrics.lyricsBody,
        id: data.message.body.lyrics.lyricsId,
        copyright: data.message.body.lyrics.lyricsCopyright,
        explicit: data.message.body.lyrics.explicit);
  }

//---Tracks---
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

  Future<TrackData> getTrack(String track, String artist) async {
    var data = await getTrackRaw(track, artist);
    if (isLogging) l.log('Got track for $track');
    return TrackData(
      albumName: data.message.body.track.albumName,
      artistName: data.message.body.track.artistName,
      confidence: data.message.header.confidence,
      explicit: data.message.body.track.explicit == 1 ? true : false,
      hasLyrics: data.message.body.track.hasLyrics == 1 ? true : false,
      trackName: data.message.body.track.trackName,
      id: data.message.body.track.trackId,
      likes: data.message.body.track.numFavourite,
      updatedTime: data.message.body.track.updatedTime,
      trackRating: data.message.body.track.trackRating,
    );
  }

  Future<TrackSearchDataRaw> getTrackSearchRaw(
      [String track, String artist, String lyrics]) async {
    final _track = track != null ? '&q_track=$track' : '';
    final _artist = artist != null ? '&q_artist=$artist' : '';
    final _lyrics = lyrics != null ? '&q_lyrics=$lyrics' : '';

    final response = await http.get(
      '${baseUrl}track.search?format=jsonp&callback=callback$_track$_artist$_lyrics&quorum_factor=1&apikey=$token',
    );
    if (response == null) return null;
    final tracks = trackSearchDataRawFromJson(
        response.body.substring(9, response.body.length - 2));
    _validator.validateStatus(tracks.message.header.statusCode);
    return tracks;
  }

  Future<List<TrackData>> searchTrack([
    String track,
    String artist,
    String lyrics,
  ]) async {
    if (isLogging)
      l.log('Searching Track: ' + track + 'from' + artist + 'lyrics:' + lyrics);
    List<TrackData> response = [];
    final data = await getTrackSearchRaw(track, artist, lyrics);
    data.message.body.trackList.forEach((element) {
      try {
        response.add(
          TrackData(
            albumName: element.track.albumName,
            artistName: element.track.artistName,
            explicit: element.track.explicit == 1 ? true : false,
            hasLyrics: element.track.hasLyrics == 1 ? true : false,
            trackName: element.track.trackName,
            trackRating: element.track.trackRating,
            id: element.track.trackId,
            likes: element.track.numFavourite,
            updatedTime: DateTime.parse(element.track.updatedTime),
          ),
        );

        response.sort((a, b) => b.likes.compareTo(a.likes));
      } catch (e) {
        l.logError('Could not parse tracks', e);
      }
    });
    if (isLogging) l.log('Search finished with ${response.length} results');
    return response;
  }

  void setValidationLogger(bool isEnabled) {
    _validator.isLogging = isEnabled;
    if (isLogging) l.log('Enabled Validation Logger');
  }
}
