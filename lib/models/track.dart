class TrackData {
  final String trackName;
  final String albumName;
  final String artistName;
  final int confidence;
  final bool hasLyrics;
  final int trackRating;
  final int likes;
  final int id;
  final bool explicit;
  final DateTime updatedTime;

  TrackData({
    this.likes,
    this.id,
    this.updatedTime,
    this.trackName,
    this.albumName,
    this.artistName,
    this.hasLyrics,
    this.trackRating,
    this.confidence,
    this.explicit,
  });
}
