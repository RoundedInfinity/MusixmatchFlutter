// To parse this JSON data, do
//
//     final trackSearchDataRaw = trackSearchDataRawFromJson(jsonString);

import 'dart:convert';

TrackSearchDataRaw trackSearchDataRawFromJson(String str) => TrackSearchDataRaw.fromJson(json.decode(str));

String trackSearchDataRawToJson(TrackSearchDataRaw data) => json.encode(data.toJson());

class TrackSearchDataRaw {
    TrackSearchDataRaw({
        this.message,
    });

    Message message;

    factory TrackSearchDataRaw.fromJson(Map<String, dynamic> json) => TrackSearchDataRaw(
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message.toJson(),
    };
}

class Message {
    Message({
        this.header,
        this.body,
    });

    Header header;
    Body body;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "body": body.toJson(),
    };
}

class Body {
    Body({
        this.trackList,
    });

    List<TrackList> trackList;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        trackList: List<TrackList>.from(json["track_list"].map((x) => TrackList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "track_list": List<dynamic>.from(trackList.map((x) => x.toJson())),
    };
}

class TrackList {
    TrackList({
        this.track,
    });

    Track track;

    factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
        track: Track.fromJson(json["track"]),
    );

    Map<String, dynamic> toJson() => {
        "track": track.toJson(),
    };
}

class Track {
    Track({
        this.instrumental,
        this.albumCoverart350X350,
        this.firstReleaseDate,
        this.trackIsrc,
        this.explicit,
        this.trackEditUrl,
        this.numFavourite,
        this.albumCoverart500X500,
        this.albumName,
        this.trackRating,
        this.trackShareUrl,
        this.trackSoundcloudId,
        this.artistName,
        this.albumCoverart800X800,
        this.albumCoverart100X100,
        this.trackNameTranslationList,
        this.trackName,
        this.restricted,
        this.hasSubtitles,
        this.updatedTime,
        this.subtitleId,
        this.lyricsId,
        this.trackSpotifyId,
        this.hasLyrics,
        this.artistId,
        this.albumId,
        this.artistMbid,
        this.commontrackVanityId,
        this.trackId,
        this.trackXboxmusicId,
        this.trackLength,
        this.trackMbid,
        this.commontrackId,
    });

    int instrumental;
    String albumCoverart350X350;
    String firstReleaseDate;
    String trackIsrc;
    int explicit;
    String trackEditUrl;
    int numFavourite;
    String albumCoverart500X500;
    String albumName;
    int trackRating;
    String trackShareUrl;
    int trackSoundcloudId;
    String artistName;
    String albumCoverart800X800;
    String albumCoverart100X100;
    List<String> trackNameTranslationList;
    String trackName;
    int restricted;
    int hasSubtitles;
    String updatedTime;
    int subtitleId;
    int lyricsId;
    String trackSpotifyId;
    int hasLyrics;
    int artistId;
    int albumId;
    String artistMbid;
    String commontrackVanityId;
    int trackId;
    String trackXboxmusicId;
    int trackLength;
    String trackMbid;
    int commontrackId;

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        instrumental: json["instrumental"],
        albumCoverart350X350: json["album_coverart_350x350"],
        firstReleaseDate: json["first_release_date"],
        trackIsrc: json["track_isrc"],
        explicit: json["explicit"],
        trackEditUrl: json["track_edit_url"],
        numFavourite: json["num_favourite"],
        albumCoverart500X500: json["album_coverart_500x500"],
        albumName: json["album_name"],
        trackRating: json["track_rating"],
        trackShareUrl: json["track_share_url"],
        trackSoundcloudId: json["track_soundcloud_id"],
        artistName: json["artist_name"],
        albumCoverart800X800: json["album_coverart_800x800"],
        albumCoverart100X100: json["album_coverart_100x100"],
        trackName: json["track_name"],
        restricted: json["restricted"],
        hasSubtitles: json["has_subtitles"],
        updatedTime: json["updated_time"],
        subtitleId: json["subtitle_id"],
        lyricsId: json["lyrics_id"],
        trackSpotifyId: json["track_spotify_id"],
        hasLyrics: json["has_lyrics"],
        artistId: json["artist_id"],
        albumId: json["album_id"],
        artistMbid: json["artist_mbid"],
        commontrackVanityId: json["commontrack_vanity_id"],
        trackId: json["track_id"],
        trackXboxmusicId: json["track_xboxmusic_id"],
        trackLength: json["track_length"],
        trackMbid: json["track_mbid"],
        commontrackId: json["commontrack_id"],
    );

    Map<String, dynamic> toJson() => {
        "instrumental": instrumental,
        "album_coverart_350x350": albumCoverart350X350,
        "first_release_date": firstReleaseDate,
        "track_isrc": trackIsrc,
        "explicit": explicit,
        "track_edit_url": trackEditUrl,
        "num_favourite": numFavourite,
        "album_coverart_500x500": albumCoverart500X500,
        "album_name": albumName,
        "track_rating": trackRating,
        "track_share_url": trackShareUrl,
        "track_soundcloud_id": trackSoundcloudId,
        "artist_name": artistName,
        "album_coverart_800x800": albumCoverart800X800,
        "album_coverart_100x100": albumCoverart100X100,
        "track_name_translation_list": List<dynamic>.from(trackNameTranslationList.map((x) => x)),
        "track_name": trackName,
        "restricted": restricted,
        "has_subtitles": hasSubtitles,
        "updated_time": updatedTime,
        "subtitle_id": subtitleId,
        "lyrics_id": lyricsId,
        "track_spotify_id": trackSpotifyId,
        "has_lyrics": hasLyrics,
        "artist_id": artistId,
        "album_id": albumId,
        "artist_mbid": artistMbid,
        "commontrack_vanity_id": commontrackVanityId,
        "track_id": trackId,
        "track_xboxmusic_id": trackXboxmusicId,
        "track_length": trackLength,
        "track_mbid": trackMbid,
        "commontrack_id": commontrackId,
    };
}

class Header {
    Header({
        this.available,
        this.statusCode,
        this.executeTime,
    });

    int available;
    int statusCode;
    double executeTime;

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        available: json["available"],
        statusCode: json["status_code"],
        executeTime: json["execute_time"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "status_code": statusCode,
        "execute_time": executeTime,
    };
}
