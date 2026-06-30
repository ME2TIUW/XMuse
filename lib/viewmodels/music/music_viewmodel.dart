import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xmuse/data/models/song_model.dart';

class MusicViewModel extends ChangeNotifier {
  List<SongModel> _songs = [];
  List<SongModel> get songs => _songs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? 'An unexpected error occurred.';

  Future<void> fetchChristmasMusic({String query = 'christmas'}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = Uri.parse(
        'https://itunes.apple.com/search?term=$query&limit=25&media=music',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];

        _songs = results
            .where((json) => json['previewUrl'] != null)
            .map((json) => SongModel.fromJson(json))
            .toList();
      } else {
        _errorMessage =
            'Failed to load music from iTunes API. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
