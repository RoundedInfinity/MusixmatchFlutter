import 'package:http/http.dart' as http;
import 'package:musixmatch/logger.dart';
import 'package:musixmatch/validator.dart';

import 'models/lyrics.dart';
import 'models/lyrics.g.dart';
import 'models/track.dart';
import 'models/track.g.dart';
import 'models/track_search_data.g.dart';

///Used to handle api calls and requests.
///
///### Musixmatch Api - How to use it
///To use the api you need to get a token from the [musixmatch website](https://developer.musixmatch.com).
///Then you have to initialize the api with the token somwhere in your code.
///
///Example:
/// ```
///var api = MusixmatchApi('YOUR API KEY')
/// ```
///Now you can call all api functions. Keep in mind that you have only a limited number of api calls.
///
///You should activate __Logging__ for debugging and testing.
///
class MusixmatchApi {
  ///If [isLogging] is true everything will be logged. Otherwise only errors and warnings will be logged.
  ///
  /// Logging is great for debugging and testing.
  ///Activate Logging if you are initializing the api.

  final bool isLogging;
  Validator _validator = Validator();
  Logger l = Logger();
  String _baseUrl = 'https://api.musixmatch.com/ws/1.1/';

  ///The base url for  musixmatch api calls.
  /// Refers to https://api.musixmatch.com/ws/1.1/
  String get baseUrl => _baseUrl;

  final String token;

  MusixmatchApi(this.token, {this.isLogging = false});

//---LYRICS---

  Future<LyricDataRaw> _getLyricsRaw(String track, String artist) async {
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

  ///Returns a [LyricsData] for the given [track] name and [artist]
  ///
  ///[track] and [artist] are necessary in order to get the lyrics.
  Future<LyricsData> getLyrics(String track, String artist) async {
    var data = await _getLyricsRaw(track, artist);
    if (isLogging) l.log('Got lyrics for $track');
    return LyricsData(
        lyricsBody: data.message.body.lyrics.lyricsBody,
        id: data.message.body.lyrics.lyricsId,
        copyright: data.message.body.lyrics.lyricsCopyright,
        explicit: data.message.body.lyrics.explicit);
  }

//---Tracks---
  Future<TrackDataRaw> _getTrackRaw(String track, String artist) async {
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

  ///Returns a [TrackData] for the given [track] name and [artist]
  ///
  ///[track] and [artist] are necessary in order to get the lyrics.
  Future<TrackData> getTrack(String track, String artist) async {
    var data = await _getTrackRaw(track, artist);
    if (isLogging) l.log('Got track for $track');
    return _rawTrackToTrack(data);
  }

  Future<TrackDataRaw> _getTrackRawById(int id) async {
    final response = await http.get(
      '${baseUrl}track.get?format=jsonp&callback=callback&track_id=$id&apikey=$token',
    );
    if (response == null) return null;

    final trackSong =
        trackFromJson(response.body.substring(9, response.body.length - 2));
    _validator.validateStatus(trackSong.message.header.statusCode);
    if (isLogging)
      l.log(
          'Got Raw Track by id for ${trackSong.message.body.track.trackName}');
    return trackSong;
  }

  ///Returns a [TrackData] for the given musixmatch [id].
  ///
  ///Easy way to get a track when you already have the song [id].
  Future<TrackData> getTrackById(int id) async {
    var data = await _getTrackRawById(id);
    if (isLogging) l.log('Got track for id $id');
    return _rawTrackToTrack(data);
  }

  TrackData _rawTrackToTrack(TrackDataRaw data) {
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

  Future<TrackSearchDataRaw> _getTrackSearchRaw(
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

  ///Search for a tracks by its [name], [artist], and/or [lyrics].
  ///Returns a [List] of [TrackData]
  ///
  ///Only one parameter has to be specified.
  ///If more parameters are given the search will be more accurate.
  ///
  ///Example:
  ///```
  /// var query = await api.searchTrack('Bohemian Rhapsody','Queen','mama, ooh');
  /// //or
  /// var query = await api.searchTrack(null,null,'Didnt mean to make you cry if Im not back again this time tomorrow');
  ///```
  Future<List<TrackData>> searchTrack([
    String track,
    String artist,
    String lyrics,
  ]) async {
    if (isLogging)
      l.log('Searching Track: ' + track + 'from' + artist + 'lyrics:' + lyrics);
    if (track == null && artist == null && lyrics == null)
      l.logError(
          'searchTrack should have any values in order to search for a track');
    List<TrackData> response = [];
    final data = await _getTrackSearchRaw(track, artist, lyrics);
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
