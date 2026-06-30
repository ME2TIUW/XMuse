class SongModel {
  final String title;
  final String artist;
  final String artworkUrl;
  final String previewUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.artworkUrl,
    required this.previewUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json['trackName'] ?? 'Unknown Title',
      artist: json['artistName'] ?? 'Unknown Artist',
      artworkUrl: json['artworkUrl100'] ?? '',
      previewUrl: json['previewUrl'] ?? '',
    );
  }
}
